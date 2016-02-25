import KituraRouter
import KituraNet
import KituraSys
import SwiftyJSON

let router = Router()
router.use("/*", middleware: BodyParser())
router.post("/entry") { request, response, next in 
    var html = ""
    let queryParams = request.body!.asUrlEncoded()!
    if let requestBody = request.body {
        if let queryParams = requestBody.asUrlEncoded() {
            let title = queryParams["title"]!
            let body = queryParams["body"]!
            html = "<h1>\(title)</h1>"
                + "<p>\(body)</p>"
        }
    }
    do {
        try response.status(HttpStatusCode.OK).send(html).end()
    }
    catch {}
    next()
}
router.get("/json") { request, response, next in
    let entries = [
        ["title":"apple", "content":"swift is a programming language"], 
        ["title":"Ringo Starr", "content":"Ringo Starr is a drummer"], 
    ]
    let json = JSON(entries)
    try! response.status(HttpStatusCode.OK).sendJson(json).end()
    next()
}
router.get("/") { request, response, next in 
    let html = "<h1>Request test</h1>"
        + "<form method=\"post\" action=\"/entry\">"
        +  "title:<br><input type=\"text\" name=\"title\" value=\"\" /><br>"
        + "body:<br><textarea name=\"body\"></textarea><br>"
        + "<input type=\"submit\" value=\"post\" /><br>"
        + "</form><br>"
        + "<a href=\"/json\">json api</a>"
    do {
        // Caution : Not HTML escape!
        try response.status(HttpStatusCode.OK).send(html).end()
    }
    catch {}
    next()
}
let server = HttpServer.listen(8090, delegate: router)
Server.run()