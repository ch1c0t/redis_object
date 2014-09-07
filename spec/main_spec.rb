require 'redis_object'

class A
  include Redis.object
end

describe 'Redis.object' do
  it 'creates a temp directory' do
    expect(Dir.exist? "/tmp/ruby.#{$$}/A").to be_truthy
  end

  it 'defines a constant R with Redis instance' do
    expect(A::R).to be_a_kind_of Redis
  end

  it 'saves Redis dump' do
    A::R.bgsave
    expect(File.exist? "/tmp/ruby.#{$$}/A/dump.rdb").to be_truthy
  end
end
