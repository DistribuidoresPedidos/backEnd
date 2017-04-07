CarrierWave.configure do |config|
  config.fog_credentials = {
	:provider               => 'AWS',
  	:aws_access_key_id      => "AKIAIENNIAGVEJE64SNA",
  	:aws_secret_access_key  => "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",
    #:region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'dealersapi'                     # required
  #config.fog_host       = 'https://assets.example.com'            # optional, defaults to nil
  #config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end