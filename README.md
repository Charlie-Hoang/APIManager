# APIManager
* A clear way to wrire network layer with moya framework
# REQUIREMENT
- ios 10.0
- swift 4.2
- Moya 11.0
# USING

1. Redefine Enpoint.swift for your own api infomation(url, endpoint, header, method)
2. create your Request Model and conform RequestModel protocol
  ex:
```
  struct LoginRequestModel: RequestModel{
      var userName: String?
      var passwd: String?
  }
```
3. create your Response Model and conform ResponseModel
  ex:
  ```
  struct LoginResponseModel: ResponseModel{
      var userId: String?
      var userName: String?
  }
  ```
4. create request function
  ex:
  ```
  func doLogin(model: LoginRequestModel, success: @escaping RESPONSE_SUCCESS, failure: @escaping RESPONSE_FAILED) {
          request(endpoint: .login(model), success: { (responseData) in
              do {
                  let res: DictResponseModel<DataResponseModel<LoginResponseModel>> = try SONDecoder().decode(DictResponseModel<DataResponseModel<LoginResponseModel>>.self, from: responseData!)
                  success(res.response?.data)
              } catch {
                  failure("Could not parse JSON")
              }
          }) { (error) in
              failure(error)
          }
  }
  ```
5. Enjoy
```
  var loginModel = LoginRequestModel()
  loginModel.userName = "abc@gmail.com"
  loginModel.passwd = "12345678"
  APIManager.shared.doLogin(model: loginModel, success: { (response) in
      if let res = response as? LoginResponseModel{
          //TODO:
          print(res)
      }
  }) { (errMsg) in
      print(errMsg!)
  }
  ```
