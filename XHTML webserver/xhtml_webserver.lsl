// example for inworld webserver that serves XHTML pages which can be properly displayed with external webbrowser

/*
substring replacement
\t    four spaces
\n    new line
\"    double quote
\\    backslash
*/

/* minimal working xhtml template

<html xmlns=\"http://www.w3.org/1999/xhtml\">
    <head>
        <title></title>
    </head>
    <body></body>
</html>

*/


string reply = "<html xmlns=\"http://www.w3.org/1999/xhtml\">
    <head>
        <title>My fucking awesome webpage from within Second Life</title>
    </head>
<body>
<h2>Blah Header</h2>
<p>blah blah blah paragraph:</p>
<a href=\"https://www.secondlife.com\">secondlife.com</a>
</body></html>
";


string url;

default
{
    state_entry()
    {
        llRequestURL();
    }

    http_request(key id, string method, string body)
    {    
        if (method == URL_REQUEST_GRANTED) 
        {
            url=body;

            llOwnerSay(url);
        }
        else if(method=="GET")
        {
              if(llGetHTTPHeader(id,"x-query-string")=="") {

                  llSetContentType(id, CONTENT_TYPE_XHTML); // setting content type to XHTML, because this can be displayed properly with external webbrowser !!!! 

                  llHTTPResponse(id, 200, reply);

              }
              else {
                  
                  llSetContentType(id, CONTENT_TYPE_TEXT); // setting content type to plain text
    
                  llHTTPResponse(id,200,llGetHTTPHeader(id,"x-query-string")); // outputs the GET variable e.g. url/?var=uuid
              }
        }        
    }
}