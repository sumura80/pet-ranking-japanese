if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['AMAZON_S3_REGION'], 
      :aws_access_key_id     => ENV['AMAZON_ACCESS_KEY_ID'],
      :aws_secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
    }
    config.fog_directory     =  ENV['AMAZON_S3_BUCKET_NAME']
  end
end
