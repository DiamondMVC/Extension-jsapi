# jsapi

Jsapi is an extension to views in Diamond, which extends views with an easy-to-use integration of js/jquery.

## extensions.config

```
ViewExtension|jsapi|diamond.extensions.jsapi
```

## API Docs

### void ajax(HTTPMethod method, string name, string url, string prepareFunction, string callbackFunction)

Requires: http://jquery.com/

This function will generate a javascript function that executes an ajax call through jquery.

Example:
```
<a href="#" onclick="authenticate()">Authenticate</a>

@:ajax(HTTPMethod.POST, "authenticate", "/login", "prepareAuth", "authenticated");

<script type="text/javascript">
function prepareAuth() {
    var authArgs = {
        data: {
           username: 'test',
           password: '1234'
        },
        dataType: 'json'
    };
    
    return authArgs;
}

function authenticated(result) {
    if (result.success) {
        console.info(result);
    } else {
        console.error("An error happened during the request.");
    }
}
</script>
```

*Note: You don't need to specify dataType if the dataType is json. The example above only has it for demonstration.*
