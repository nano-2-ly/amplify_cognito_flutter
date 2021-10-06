# amplify_cognito_flutter

Build sign in application using flutter, getx, aws cognito, and aws amplify.

## Getting Started

# 1. pubspec.yaml
~~~
pub get
~~~

# 2. init amplify
If you didn't install AWS Amplify CLI, download CLI with below command.
~~~
npm install -g @aws-amplify/cli@flutter-preview
~~~

When you install successfully, initiate amplify in your project.
~~~
amplify init
~~~

# 3. add cognito in your amplify
~~~
amplify add auth
~~~

# 4. apply your local amplify settings to aws cloud server
~~~
amplify push
~~~

# 5. run code
Hello world! Have a nice day! :D
