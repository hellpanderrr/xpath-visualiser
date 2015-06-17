<!DOCTYPE html>
<html>
<head>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src=
    "//ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
    <style media="screen" type="text/css">

    @-webkit-keyframes pulse-border {
    from, to { box-shadow: 0 0 0 0 black;}
    50% { box-shadow: 0 0 0 4px black; }
    }
    div.line {            -webkit-transform-origin: 0 100%;            height: 3px; /* Line width of 3 */            background: #000; /* Black fill */        }

    </style>

    <title></title>
</head>

<body>
    <div class="col-sm-8">
        <form action="javascript:void(0)">
            <input class="button" id="submit3" type="submit" value="Submit">
            <input id="path" type="text">path <input id="code" type="text">
        </form><iframe align="left" height="2000px" id="iframe" name="iframe"
        width="100%"><style media="screen" type="text/css">

        @-webkit-keyframes pulse-border {
        from, to { box-shadow: 0 0 0 0 black;}
        50% { box-shadow: 0 0 0 4px black; }
        }
        div.line {            -webkit-transform-origin: 0 100%;            height: 3px; /* Line width of 3 */            background: #000; /* Black fill */        }

        </style></iframe>
    </div><script type="text/javascript">
$.wait = function(ms) {
    var defer = $.Deferred();
    setTimeout(function() { defer.resolve(); }, ms);
    return defer;
    };  
    function createLine(x1,y1, x2,y2){
    var length = Math.sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
    var angle  = Math.atan2(y2 - y1, x2 - x1) * 180 / Math.PI;
    var transform = 'rotate('+angle+'deg)';

    var line = $('<div>')
        .appendTo('body')
        .addClass('line')
        .css({
          'position': 'absolute',
          'transform': transform
        })
        .width(length)
        .offset({left: x1, top: y1});

    return line;
    }

    $('#submit3').click(function () {


        $.ajax({
            url: '/hello/123',
            type: 'POST',
            data: JSON.stringify({
                'path': $('#path').val(),
                'code': $('#code').val()
            }),
                        contentType: "application/json; charset=utf-8",

            dataType: 'json',
            success: function (json) {
                console.log(json)
                $.wait(200)
                var doc = document.getElementById('iframe').contentWindow.document;
                doc.open();
                doc.write(json['html']);
                doc.close();

            }
        })});
        l = $('iframe').contents().find('[new=specialsnowflake')
        
        
    </script>
</body>
</html>