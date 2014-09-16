require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

# client.event stubs
def stub_single_event_success
  WebMock.stub_request(:get, "http://mock.me/?id=501").to_return(:status => 200, :body => File.read(File.join(SAMPLES, 'single_event_success.json')), :headers => {})
end

def stub_single_event_no_data
  WebMock.stub_request(:get, "http://mock.me/?id=502").to_return(:status => 200, :body => '', :headers => {})
end

def stub_single_event_weird_data
  WebMock.stub_request(:get, "http://mock.me/?id=503").to_return(:status => 200, :body => '<html><head><title>This page has moved</title></head><body><h1>This is not JSON!!</h1></body></html>', :headers => {})
end

def stub_single_event_empty_array
  WebMock.stub_request(:get, "http://mock.me/?id=504").to_return(:status => 200, :body => '[]', :headers => {})
end

# client.events stubs
def stub_events_with_good_data
  WebMock.stub_request(:get, "http://mock.me/?end=2001-01-01&start=2000-01-01").to_return(:status => 200, :body => File.read(File.join(SAMPLES, 'multiple_events_success.json')), :headers => {})
end

def stub_events_no_data
  WebMock.stub_request(:get, "http://mock.me/?end=2000-01-02&start=2000-01-01").to_return(:status => 200, :body => '[]', :headers => {})
end

def stub_events_with_weird_data
  WebMock.stub_request(:get, "http://mock.me/?end=2000-01-02&start=2000-01-01").to_return(:status => 200, :body => '<html><head><title>This page has moved</title></head><body><h1>This is not JSON!!</h1></body></html>', :headers => {})
end