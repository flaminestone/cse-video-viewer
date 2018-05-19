(function (window, undefined) {

    // for timing start
    window.frameTime = -1;
    window.frameIndex = -1;
    window.frameDuration = 1;

    //for timing end
    Asc.scope.st = 0;

    window.Asc.plugin.init = function () {
        console.log('init');
        var xhr = new XMLHttpRequest();
        xhr.open("POST", '/api/get_frame', true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                window.data = JSON.parse(xhr.responseText).data;
                window.Asc.plugin.onCommandCallback();
            }
        };
        xhr.send("resolution=30x30");
    };

    function wait_and_run() {
        var time = new Date().getTime();
        if (window.frameTime === -1) {
            window.frameTime = time;
        } else {
            var delay = time - window.frameTime;
            if (delay < window.frameDuration) {
                setTimeout(function () {
                    wait_and_run();
                }, window.frameDuration - delay);
            }
            else {
                window.frameTime = time;
            }
        }
        window.frameIndex++;
        console.log( window.frameIndex);
        if (window.frameIndex >= window.data.length) {
            window.Asc.plugin.executeCommand("close", "");
            return;
        }
        Asc.scope.st = window.data[window.frameIndex]
    }

    window.Asc.plugin.onCommandCallback = function () {
        // window.frameIndex++;
        // Asc.scope.st = window.data[window.frameIndex];
        wait_and_run();
        this.callCommand(function () {
            var image = new Image();
            image.src = Asc.scope.st;
            var rr = new Date().getTime();
            image.onload = function () {
                var Sheet = Api.GetActiveSheet();

                var w = 30;
                var h = 30;
                window.canvasPlugin = window.canvasPlugin ? window.canvasPlugin : document.createElement("canvas");
                var canvas = window.canvasPlugin;
                canvas.width = w;
                canvas.height = h;
                canvas.getContext('2d').drawImage(this, 0, 0, w, h);

                var colors = canvas.getContext('2d').getImageData(0, 0, w, h).data;
                var index = 0;
                for (var y = 0; y < h; y++) {
                    for (var x = 0; x < w; x++) {
                        Sheet.GetRangeByNumber(x, y).SetFillColor(Api.CreateColorFromRGB(colors[index++], colors[index++], colors[index++]));
                        index++;
                    }
                }

                canvas = null;
                rr = new Date().getTime() - rr;
                console.log(":time " + rr);
            };
        }, false);
    };
})(window, undefined);
