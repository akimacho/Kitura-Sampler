import KituraRouter
import KituraNet
import KituraSys

let router = Router()

router.get("/entry") { _, response, next in
    let html = "<h1>GET /entry</h1>"
    + "<form method=\"post\" action=\"/entry\"><input type=\"submit\" value=\"post\" /></form>"
    do {
        try response.status(HttpStatusCode.OK).send(html).end()
    }
    catch {}
    next()
}
router.post("/entry") {request, response, next in
    do {
        try response.status(HttpStatusCode.OK).send("<h1>POST /entry</h1>").end()
    }
    catch {}
    next()
}
router.get("/hello/:name") {request, response, next in
    do {
        if let name = request.params["name"] {
            try response.status(HttpStatusCode.OK).send("<h1>Hello, \(name)</h1>").end()
        } else {
            try response.status(HttpStatusCode.OK).send("<h1>Hello, noname</h1>").end()
        }
    }
    catch {}
    next()
}
router.get("/redirect") { _, response, next in
    do {
        try response.redirect("/")
    }
    catch {}
    next()
}
router.get("/") { request, response, next in
    let html = "<h1>GET /</h1>"
        + "<a href=\"entry\">entry</a><br/>"
        + "<a href=\"/hello/taro\">/hello/taro</a><br/>"
        + "<a href=\"/redirect\">/redirect</a><br/>"
    do {
        try response.status(HttpStatusCode.OK).send(html).end()
    }
    catch {}
    next()
}
let server = HttpServer.listen(8090, delegate: router)
Server.run()