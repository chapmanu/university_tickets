require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

# Stub the request for event #501 to return the proper response
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