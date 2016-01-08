Rails.application.config.middleware.use OmniAuth::Builder do
  
provider :facebook, '1490106254631423', '90765004a269b980e23d736bd2c06055'
end