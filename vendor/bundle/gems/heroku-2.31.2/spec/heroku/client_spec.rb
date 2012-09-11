require "spec_helper"
require "heroku/client"
require "heroku/helpers"
require 'heroku/command'

describe Heroku::Client do
  include Heroku::Helpers

  before do
    @client = Heroku::Client.new(nil, nil)
    @resource = mock('heroku rest resource')
    @client.stub!(:extract_warning)
  end

  it "Client.auth -> get user details" do
    user_info = { "api_key" => "abc" }
    stub_request(:post, "https://foo:bar@api.heroku.com/login").to_return(:body => json_encode(user_info))
    capture_stderr do # capture deprecation message
      Heroku::Client.auth("foo", "bar").should == user_info
    end
  end

  it "list -> get a list of this user's apps" do
    stub_api_request(:get, "/apps").to_return(:body => <<-EOXML)
      <?xml version='1.0' encoding='UTF-8'?>
      <apps type="array">
        <app><name>myapp1</name><owner>test@heroku.com</owner></app>
        <app><name>myapp2</name><owner>test@heroku.com</owner></app>
      </apps>
    EOXML
    capture_stderr do # capture deprecation message
      @client.list.should == [
        ["myapp1", "test@heroku.com"],
        ["myapp2", "test@heroku.com"]
      ]
    end
  end

  it "info -> get app attributes" do
    stub_api_request(:get, "/apps/myapp").to_return(:body => <<-EOXML)
      <?xml version='1.0' encoding='UTF-8'?>
      <app>
        <blessed type='boolean'>true</blessed>
        <created-at type='datetime'>2008-07-08T17:21:50-07:00</created-at>
        <id type='integer'>49134</id>
        <name>myapp</name>
        <production type='boolean'>true</production>
        <share-public type='boolean'>true</share-public>
        <domain_name/>
      </app>
    EOXML
    @client.stub!(:list_collaborators).and_return([:jon, :mike])
    @client.stub!(:installed_addons).and_return([:addon1])
    capture_stderr do # capture deprecation message
      @client.info('myapp').should == { :blessed => 'true', :created_at => '2008-07-08T17:21:50-07:00', :id => '49134', :name => 'myapp', :production => 'true', :share_public => 'true', :domain_name => nil, :collaborators => [:jon, :mike], :addons => [:addon1] }
    end
  end

  it "create_request -> create a new blank app" do
    stub_api_request(:post, "/apps").with(:body => "").to_return(:body => <<-EOXML)
      <?xml version="1.0" encoding="UTF-8"?>
      <app><name>untitled-123</name></app>
    EOXML
    capture_stderr do # capture deprecation message
      @client.create_request.should == "untitled-123"
    end
  end

  it "create_request(name) -> create a new blank app with a specified name" do
    stub_api_request(:post, "/apps").with(:body => "app[name]=newapp").to_return(:body => <<-EOXML)
      <?xml version="1.0" encoding="UTF-8"?>
      <app><name>newapp</name></app>
    EOXML
    capture_stderr do # capture deprecation message
      @client.create_request("newapp").should == "newapp"
    end
  end

  it "create_complete?(name) -> checks if a create request is complete" do
    @response = mock('response')
    @response.should_receive(:code).and_return(202)
    @client.should_receive(:resource).and_return(@resource)
    @resource.should_receive(:put).with({}, @client.heroku_headers).and_return(@response)
    capture_stderr do # capture deprecation message
      @client.create_complete?('myapp').should be_false
    end
  end

  it "update(name, attributes) -> updates existing apps" do
    stub_api_request(:put, "/apps/myapp").with(:body => "app[mode]=production")
    capture_stderr do # capture deprecation message
      @client.update("myapp", :mode => 'production')
    end
  end

  it "destroy(name) -> destroy the named app" do
    stub_api_request(:delete, "/apps/destroyme")
    capture_stderr do # capture deprecation message
      @client.destroy("destroyme")
    end
  end

  it "rake(app_name, cmd) -> run a rake command on the app" do
    stub_api_request(:post, "/apps/myapp/services").with(:body => "rake db:migrate").to_return(:body => "foo")
    stub_api_request(:get,  "/foo").to_return(:body => "output")
    capture_stderr do # capture deprecation message
      @client.rake('myapp', 'db:migrate')
    end
  end

  it "console(app_name, cmd) -> run a console command on the app" do
    stub_api_request(:post, "/apps/myapp/console").with(:body => "command=2%2B2")
    @client.console('myapp', '2+2')
  end

  it "console(app_name) { |c| } -> opens a console session, yields one accessor and closes it after the block" do
    stub_api_request(:post,   "/apps/myapp/consoles").to_return(:body => "consolename")
    stub_api_request(:post,   "/apps/myapp/consoles/consolename/command").with(:body => "command=1%2B1").to_return(:body => "2")
    stub_api_request(:delete, "/apps/myapp/consoles/consolename")

    @client.console('myapp') do |c|
      c.run("1+1").should == '=> 2'
    end
  end

  it "shows an error message when a console request fails" do
    stub_request(:post, %r{.*/apps/myapp/console}).to_return({
      :body => "ERRMSG", :status => 502
    })
    lambda { @client.console('myapp') }.should raise_error(Heroku::Client::AppCrashed, /Your application may have crashed/)
  end

  it "restart(app_name) -> restarts the app servers" do
    stub_api_request(:delete, "/apps/myapp/server")
    capture_stderr do # capture deprecation message
      @client.restart('myapp')
    end
  end

  describe "read_logs" do
    describe "old style" do
      before(:each) do
        stub_api_request(:get, "/apps/myapp/logs?logplex=true").to_return(:body => "Use old logs")
        stub_api_request(:get, "/apps/myapp/logs").to_return(:body => "oldlogs")
      end

      it "can read old style logs" do
        @client.should_receive(:puts).with("oldlogs")
        @client.read_logs("myapp")
      end
    end

    describe "new style" do
      before(:each) do
        stub_api_request(:get, "/apps/myapp/logs?logplex=true").to_return(:body => "https://logplex.heroku.com/identifier")
        stub_request(:get, "https://logplex.heroku.com/identifier").to_return(:body => "newlogs")
      end

      it "can read new style logs" do
        @client.read_logs("myapp") do |logs|
          logs.should == "newlogs"
        end
      end
    end
  end

  it "logs(app_name) -> returns recent output of the app logs" do
    stub_api_request(:get, "/apps/myapp/logs").to_return(:body => "log")
    capture_stderr do # capture deprecation message
      @client.logs('myapp').should == 'log'
    end
  end

  it "can get the number of dynos" do
    stub_api_request(:get, "/apps/myapp").to_return(:body => <<-EOXML)
      <?xml version='1.0' encoding='UTF-8'?>
      <app>
        <dynos type='integer'>5</dynos>
      </app>
    EOXML
    capture_stderr do # capture deprecation message
      @client.dynos('myapp').should == 5
    end
  end

  it "can get the number of workers" do
    stub_api_request(:get, "/apps/myapp").to_return(:body => <<-EOXML)
      <?xml version='1.0' encoding='UTF-8'?>
      <app>
        <workers type='integer'>5</workers>
      </app>
    EOXML
    capture_stderr do # capture deprecation message
      @client.workers('myapp').should == 5
    end
  end

  it "set_dynos(app_name, qty) -> scales the app" do
    stub_api_request(:put, "/apps/myapp/dynos").with(:body => "dynos=3")
    capture_stderr do # capture deprecation message
      @client.set_dynos('myapp', 3)
    end
  end

  it "rake catches 502s and shows the app crashlog" do
    e = RestClient::RequestFailed.new
    e.stub!(:http_code).and_return(502)
    e.stub!(:http_body).and_return('the crashlog')
    @client.should_receive(:post).and_raise(e)
    capture_stderr do # capture deprecation message
      lambda { @client.rake('myapp', '') }.should raise_error(Heroku::Client::AppCrashed)
    end
  end

  it "rake passes other status codes (i.e., 500) as standard restclient exceptions" do
    e = RestClient::RequestFailed.new
    e.stub!(:http_code).and_return(500)
    e.stub!(:http_body).and_return('not a crashlog')
    @client.should_receive(:post).and_raise(e)
    capture_stderr do # capture deprecation message
      lambda { @client.rake('myapp', '') }.should raise_error(RestClient::RequestFailed)
    end
  end

  describe "ps_scale" do
    it "scales a process and returns the new count" do
      stub_api_request(:post, "/apps/myapp/ps/scale").with(:body => { :type => "web", :qty => "5" }).to_return(:body => "5")
      capture_stderr do # capture deprecation message
        @client.ps_scale("myapp", :type => "web", :qty => "5").should == 5
      end
    end
  end

  describe "collaborators" do
    it "list(app_name) -> list app collaborators" do
      stub_api_request(:get, "/apps/myapp/collaborators").to_return(:body => <<-EOXML)
        <?xml version="1.0" encoding="UTF-8"?>
        <collaborators type="array">
          <collaborator><email>joe@example.com</email></collaborator>
          <collaborator><email>jon@example.com</email></collaborator>
        </collaborators>
      EOXML
      capture_stderr do # capture deprecation message
        @client.list_collaborators('myapp').should == [
          { :email => 'joe@example.com' },
          { :email => 'jon@example.com' }
        ]
      end
    end

    it "add_collaborator(app_name, email) -> adds collaborator to app" do
      stub_api_request(:post, "/apps/myapp/collaborators").with(:body => "collaborator%5Bemail%5D=joe%40example.com")
      capture_stderr do # capture deprecation message
        @client.add_collaborator('myapp', 'joe@example.com')
      end
    end

    it "remove_collaborator(app_name, email) -> removes collaborator from app" do
      stub_api_request(:delete, "/apps/myapp/collaborators/joe%40example%2Ecom")
      capture_stderr do # capture deprecation message
        @client.remove_collaborator('myapp', 'joe@example.com')
      end
    end
  end

  describe "domain names" do
    it "list(app_name) -> list app domain names" do
      stub_api_request(:get, "/apps/myapp/domains").to_return(:body => <<-EOXML)
        <?xml version="1.0" encoding="UTF-8"?>
        <domain-names type="array">
          <domain-name><domain>example1.com</domain></domain-name>
          <domain-name><domain>example2.com</domain></domain-name>
        </domain-names>
      EOXML
      capture_stderr do # capture deprecation message
        @client.list_domains('myapp').should == [{:domain => 'example1.com'}, {:domain => 'example2.com'}]
      end
    end

    it "add_domain(app_name, domain) -> adds domain name to app" do
      stub_api_request(:post, "/apps/myapp/domains").with(:body => "example.com")
      capture_stderr do # capture deprecation message
        @client.add_domain('myapp', 'example.com')
      end
    end

    it "remove_domain(app_name, domain) -> removes domain name from app" do
      stub_api_request(:delete, "/apps/myapp/domains/example.com")
      capture_stderr do # capture deprecation message
        @client.remove_domain('myapp', 'example.com')
      end
    end

    it "remove_domain(app_name, domain) -> makes sure a domain is set" do
      lambda do
        capture_stderr do # capture deprecation message
          @client.remove_domain('myapp', '')
        end
      end.should raise_error(ArgumentError)
    end

    it "remove_domains(app_name) -> removes all domain names from app" do
      stub_api_request(:delete, "/apps/myapp/domains")
      capture_stderr do # capture deprecation message
        @client.remove_domains('myapp')
      end
    end

    it "add_ssl(app_name, pem, key) -> adds a ssl cert to the domain" do
      stub_api_request(:post, "/apps/myapp/ssl").with do |request|
        body = CGI::parse(request.body)
        body["key"].first.should == "thekey"
        body["pem"].first.should == "thepem"
      end.to_return(:body => "{}")
      @client.add_ssl('myapp', 'thepem', 'thekey')
    end

    it "remove_ssl(app_name, domain) -> removes the ssl cert for the domain" do
      stub_api_request(:delete, "/apps/myapp/domains/example.com/ssl")
      @client.remove_ssl('myapp', 'example.com')
    end
  end

  describe "SSH keys" do
    it "fetches a list of the user's current keys" do
      stub_api_request(:get, "/user/keys").to_return(:body => <<-EOXML)
        <?xml version="1.0" encoding="UTF-8"?>
        <keys type="array">
          <key>
            <contents>ssh-dss thekey== joe@workstation</contents>
          </key>
        </keys>
      EOXML
      capture_stderr do # capture deprecation message
        @client.keys.should == [ "ssh-dss thekey== joe@workstation" ]
      end
    end

    it "add_key(key) -> add an SSH key (e.g., the contents of id_rsa.pub) to the user" do
      stub_api_request(:post, "/user/keys").with(:body => "a key")
      capture_stderr do # capture deprecation message
        @client.add_key('a key')
      end
    end

    it "remove_key(key) -> remove an SSH key by name (user@box)" do
      stub_api_request(:delete, "/user/keys/joe%40workstation")
      capture_stderr do # capture deprecation message
        @client.remove_key('joe@workstation')
      end
    end

    it "remove_all_keys -> removes all SSH keys for the user" do
      stub_api_request(:delete, "/user/keys")
      capture_stderr do # capture deprecation message
        @client.remove_all_keys
      end
    end

    it "database_session(app_name) -> creates a taps database session" do
      module ::Taps
        def self.version
          "0.3.0"
        end
      end

      stub_api_request(:post, "/apps/myapp/database/session2").to_return(:body => "{\"session_id\":\"x234\"}")
      @client.database_session('myapp')
    end

    it "database_reset(app_name) -> reset an app's database" do
      stub_api_request(:post, "/apps/myapp/database/reset")
      @client.database_reset('myapp')
    end

    it "maintenance(app_name, :on) -> sets maintenance mode for an app" do
      stub_api_request(:post, "/apps/myapp/server/maintenance").with(:body => "maintenance_mode=1")
      capture_stderr do # capture deprecation message
        @client.maintenance('myapp', :on)
      end
    end

    it "maintenance(app_name, :off) -> turns off maintenance mode for an app" do
      stub_api_request(:post, "/apps/myapp/server/maintenance").with(:body => "maintenance_mode=0")
      capture_stderr do # capture deprecation message
        @client.maintenance('myapp', :off)
      end
    end
  end

  describe "config vars" do
    it "config_vars(app_name) -> json hash of config vars for the app" do
      stub_api_request(:get, "/apps/myapp/config_vars").to_return(:body => '{"A":"one", "B":"two"}')
      capture_stderr do # capture deprecation message
        @client.config_vars('myapp').should == { 'A' => 'one', 'B' => 'two'}
      end
    end

    it "add_config_vars(app_name, vars)" do
      stub_api_request(:put, "/apps/myapp/config_vars").with(:body => '{"x":"y"}')
      capture_stderr do # capture deprecation message
        @client.add_config_vars('myapp', {'x'=> 'y'})
      end
    end

    it "remove_config_var(app_name, key)" do
      stub_api_request(:delete, "/apps/myapp/config_vars/mykey")
      capture_stderr do # capture deprecation message
        @client.remove_config_var('myapp', 'mykey')
      end
    end

    it "clear_config_vars(app_name) -> resets all config vars for this app" do
      stub_api_request(:delete, "/apps/myapp/config_vars")
      capture_stderr do # capture deprecation message
        @client.clear_config_vars('myapp')
      end
    end

    it "can handle config vars with special characters" do
      stub_api_request(:delete, "/apps/myapp/config_vars/foo%5Bbar%5D")
      capture_stderr do # capture deprecation message
        lambda { @client.remove_config_var('myapp', 'foo[bar]') }.should_not raise_error
      end
    end
  end

  describe "addons" do
    it "addons -> array with addons available for installation" do
      stub_api_request(:get, "/addons").to_return(:body => '[{"name":"addon1"}, {"name":"addon2"}]')
      @client.addons.should == [{'name' => 'addon1'}, {'name' => 'addon2'}]
    end

    it "installed_addons(app_name) -> array of installed addons" do
      stub_api_request(:get, "/apps/myapp/addons").to_return(:body => '[{"name":"addon1"}]')
      @client.installed_addons('myapp').should == [{'name' => 'addon1'}]
    end

    it "install_addon(app_name, addon_name)" do
      stub_api_request(:post, "/apps/myapp/addons/addon1")
      @client.install_addon('myapp', 'addon1').should be_nil
    end

    it "upgrade_addon(app_name, addon_name)" do
      stub_api_request(:put, "/apps/myapp/addons/addon1")
      @client.upgrade_addon('myapp', 'addon1').should be_nil
    end

    it "downgrade_addon(app_name, addon_name)" do
      stub_api_request(:put, "/apps/myapp/addons/addon1")
      @client.downgrade_addon('myapp', 'addon1').should be_nil
    end

    it "uninstall_addon(app_name, addon_name)" do
      stub_api_request(:delete, "/apps/myapp/addons/addon1?").
        to_return(:body => json_encode({"message" => nil, "price" => "free", "status" => "uninstalled"}))

      @client.uninstall_addon('myapp', 'addon1').should be_true
    end

    it "uninstall_addon(app_name, addon_name) with confirmation" do
      stub_api_request(:delete, "/apps/myapp/addons/addon1?confirm=myapp").
        to_return(:body => json_encode({"message" => nil, "price" => "free", "status" => "uninstalled"}))

      @client.uninstall_addon('myapp', 'addon1', :confirm => "myapp").should be_true
    end

    it "install_addon(app_name, addon_name) with response" do
      stub_request(:post, "https://api.heroku.com/apps/myapp/addons/addon1").
        to_return(:body => json_encode({'price' => 'free', 'message' => "Don't Panic"}))

      @client.install_addon('myapp', 'addon1').
        should == { 'price' => 'free', 'message' => "Don't Panic" }
    end

    it "upgrade_addon(app_name, addon_name) with response" do
      stub_request(:put, "https://api.heroku.com/apps/myapp/addons/addon1").
        to_return(:body => json_encode('price' => 'free', 'message' => "Don't Panic"))

      @client.upgrade_addon('myapp', 'addon1').
        should == { 'price' => 'free', 'message' => "Don't Panic" }
    end

    it "downgrade_addon(app_name, addon_name) with response" do
      stub_request(:put, "https://api.heroku.com/apps/myapp/addons/addon1").
        to_return(:body => json_encode('price' => 'free', 'message' => "Don't Panic"))

      @client.downgrade_addon('myapp', 'addon1').
        should == { 'price' => 'free', 'message' => "Don't Panic" }
    end

    it "uninstall_addon(app_name, addon_name) with response" do
      stub_api_request(:delete, "/apps/myapp/addons/addon1?").
        to_return(:body => json_encode('price'=> 'free', 'message'=> "Don't Panic"))

      @client.uninstall_addon('myapp', 'addon1').
        should == { 'price' => 'free', 'message' => "Don't Panic" }
    end
  end

  describe "internal" do
    before do
      @client = Heroku::Client.new(nil, nil)
    end

    it "creates a RestClient resource for making calls" do
      @client.stub!(:host).and_return('heroku.com')
      @client.stub!(:user).and_return('joe@example.com')
      @client.stub!(:password).and_return('secret')

      res = @client.resource('/xyz')

      res.url.should == 'https://api.heroku.com/xyz'
      res.user.should == 'joe@example.com'
      res.password.should == 'secret'
    end

    it "appends the api. prefix to the host" do
      @client.host = "heroku.com"
      @client.resource('/xyz').url.should == 'https://api.heroku.com/xyz'
    end

    it "doesn't add the api. prefix to full hosts" do
      @client.host = 'http://resource'
      res = @client.resource('/xyz')
      res.url.should == 'http://resource/xyz'
    end

    it "runs a callback when the API sets a warning header" do
      response = mock('rest client response', :headers => { :x_heroku_warning => 'Warning' })
      @client.should_receive(:resource).and_return(@resource)
      @resource.should_receive(:get).and_return(response)
      @client.on_warning { |msg| @callback = msg }
      @client.get('test')
      @callback.should == 'Warning'
    end

    it "doesn't run the callback twice for the same warning" do
      response = mock('rest client response', :headers => { :x_heroku_warning => 'Warning' })
      @client.stub!(:resource).and_return(@resource)
      @resource.stub!(:get).and_return(response)
      @client.on_warning { |msg| @callback_called ||= 0; @callback_called += 1 }
      @client.get('test1')
      @client.get('test2')
      @callback_called.should == 1
    end
  end

  describe "stacks" do
    it "list_stacks(app_name) -> json hash of available stacks" do
      stub_api_request(:get, "/apps/myapp/stack?include_deprecated=false").to_return(:body => '{"stack":"one"}')
      capture_stderr do # capture deprecation message
        @client.list_stacks("myapp").should == { 'stack' => 'one' }
      end
    end

    it "list_stacks(app_name, include_deprecated=true) passes the deprecated option" do
      stub_api_request(:get, "/apps/myapp/stack?include_deprecated=true").to_return(:body => '{"stack":"one"}')
      capture_stderr do # capture deprecation message
        @client.list_stacks("myapp", :include_deprecated => true).should == { 'stack' => 'one' }
      end
    end
  end
end
