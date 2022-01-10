use actix_web::web::Data;
use actix_web::{FromRequest, error::ErrorUnauthorized};
use actix_web::{Error, HttpRequest, dev};
use futures::future::{ok, err, Ready};


pub struct ApiKeyConfig {
    pub api_key: String,
}
pub struct ApiKey;

impl FromRequest for ApiKey {
    type Error = Error;
    type Future = Ready<Result<Self, Error>>;
    type Config = ();
    fn from_request(req: &HttpRequest, _: &mut dev::Payload) -> Self::Future {
        let potential_api_key = req.headers().get("x-api-key");
        if potential_api_key.is_none() {
            return err(ErrorUnauthorized("No API key provided"));
        }
        let provided_api_key = potential_api_key.unwrap();
        let configured_api_key = req.app_data::<Data<ApiKeyConfig>>().unwrap().api_key.clone();
        if provided_api_key.to_str().unwrap() != configured_api_key {
            return err(ErrorUnauthorized("Invalid API key"));
        }
        ok(ApiKey)
    }
}
