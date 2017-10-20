/**
* Copyright © DiamondMVC 2016-2017
* License: MIT (https://github.com/DiamondMVC/Diamond/blob/master/LICENSE)
* Author: Jacob Jensen (bausshf)
*/
module diamond.extensions.jsapi;

mixin template extensions()
{
  public import vibe.d : HTTPMethod;

  private static const string ajaxFormat = `
    <script type="text/javascript">
      function %s() {
        var req = %s() || {
          data: undefined,
          dataType: 'json'
        };

        req.url = '%s';

        $.ajax({
          method: '%s',
          data: req.data,
          dataType: req.dataType,
          contentType: req.dataType === 'json' ? 'application/json; charset=utf-8' : req.contentType,
          url: window.location.protocol + '//' + window.location.host + (req.params ? (req.url + '?' + $.params(req.params)) : req.url),
          success: function(result,status,xhr) {
            %s({
              result: result,
              status: status,
              xhr: xhr,
              success: true
            });
          },
          error: function(xhr,status,error) {
            %s({
                xhr: xhr,
                status: status,
                error: error,
                success: false
            });
          }
        });
      }
    }
`;

  /**
  * Creates an ajax call function.
  * Params:
  *   method =            The method of the ajax call.
  *   name =              The name of the call.
  *   url =               The url of the call.
  *   prepareFunction =   The function to call when preparing the request.
  *   callbackFunction =  The function to call after the request has finished.
  */
  void ajax(HTTPMethod method, string name, string url, string prepareFunction, string callbackFunction)
  {
    import std.conv : to;
    import std.string : format;

    append(ajaxFormat.format(name, prepareFunction, url, to!string(method), callbackFunction, callbackFunction));
  }
}
