require File.expand_path(File.join(File.dirname(__FILE__),'..', '..','test_helper'))

class NewRelic::Agent::StatsHashTest < Test::Unit::TestCase
  def setup
    @hash = NewRelic::Agent::StatsHash.new
  end

  def test_creates_default_entries
    stats = @hash['a/b/c/d']
    assert_kind_of(NewRelic::Agent::Stats, stats)
  end

  def test_record_accpets_single_metric_spec
    spec = NewRelic::MetricSpec.new('foo/bar')
    stats = @hash[spec]
    stats.expects(:record_data_point).with(42)
    @hash.record(spec, 42)
  end

  def test_record_accepts_multiple_metric_specs
    spec1 = NewRelic::MetricSpec.new('foo/bar', 'scope1')
    spec2 = NewRelic::MetricSpec.new('foo/bar', 'scope2')
    stats1 = @hash[spec1]
    stats2 = @hash[spec2]
    stats1.expects(:record_data_point).with(42)
    stats2.expects(:record_data_point).with(42)
    @hash.record([spec1, spec2], 42)
  end

  def test_record_accepts_single_metric_spec_with_block
    spec = NewRelic::MetricSpec.new('foo')
    stats = @hash[spec]
    stats.expects(:do_stuff)
    @hash.record(spec) do |s|
      s.do_stuff
    end
  end

  def test_record_accepts_multiple_metric_specs_with_block
    specs = [
      NewRelic::MetricSpec.new('foo'),
      NewRelic::MetricSpec.new('bar')
    ]
    stats = specs.map { |spec| @hash[spec] }
    stats.each { |stat| stat.expects(:do_stuff) }
    @hash.record(specs) do |s|
      s.do_stuff
    end
  end

  def test_record_accepts_stats_value
    spec = NewRelic::MetricSpec.new('foo')
    other_stats = NewRelic::Agent::Stats.new
    stats = @hash[spec]
    stats.expects(:merge!).with(other_stats)
    @hash.record(spec, other_stats)
  end

  def test_merge_merges
    specs = [
      NewRelic::MetricSpec.new('foo'),
      NewRelic::MetricSpec.new('bar'),
      NewRelic::MetricSpec.new('baz'),
      NewRelic::MetricSpec.new('baz', 'a_scope')
    ]

    hash1 = NewRelic::Agent::StatsHash.new
    hash1.record(specs[0], 1)
    hash1.record(specs[1], 2)
    hash1.record(specs[2], 3)

    hash2 = NewRelic::Agent::StatsHash.new
    hash2.record(specs[0], 1)
    hash2.record(specs[1], 2)
    hash2.record(specs[3], 3) # no scope

    hash1.merge!(hash2)

    assert_equal(4, hash1.keys.size)
    assert_equal(2, hash1[specs[0]].call_count)
    assert_equal(2, hash1[specs[1]].call_count)
    assert_equal(1, hash1[specs[2]].call_count)
    assert_equal(1, hash1[specs[3]].call_count)
  end

  def test_marshal_dump
    hash = NewRelic::Agent::StatsHash.new()
    hash.record('foo', 1)
    hash.record('bar', 2)
    copy = Marshal.load(Marshal.dump(hash))
    assert_equal(hash, copy)
  end
end
