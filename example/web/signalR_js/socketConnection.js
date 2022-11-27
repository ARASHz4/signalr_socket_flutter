console.log("signalr socket connection v1.0")

function connectSocket(url, hubName, eventName, queryString) {
    initSocket(url, hubName, eventName, queryString)
}

function disconnectSocket() {
    stopSocket()
}

if (typeof $.hubConnection != 'undefined') {
    var placeConnection

    function initSocket(url, hubName, eventName, queryString) {
        if (typeof placeConnection == 'undefined') {
            placeConnection = $.hubConnection("/socket", { useDefaultPath: false })

            placeConnection.url = url

            placeConnection.qs = queryString

            var hubProxy = placeConnection.createHubProxy(hubName)

            hubProxy.on(eventName, function (message) {
                window.newMessage(JSON.stringify(message))
            })
        }

        startSocket()
    }

    function startSocket() {
        if (typeof placeConnection != 'undefined') {
            console.log('starting connection ' + placeConnection.url + '...')

            window.connectionStatus(1)

            placeConnection.start()
                .done(function () {
                    console.log(placeConnection.url + ' connected, connection ID =' + placeConnection.id)

                    window.connectionStatus(0)
                })
                .fail(function () {
                    console.log(placeConnection.url + ' could not connect')

                    window.connectionStatus(6)
                })
        }
        else {
            console.log('placeConnection is undefined')
        }
    }

    function stopSocket() {
        if (typeof placeConnection != 'undefined') {
            console.log('stoping connection ' + placeConnection.url + '...')

            placeConnection.stop()

            window.connectionStatus(2)
        }
        else {
            console.log('placeConnection is undefined')
        }
    }
}
