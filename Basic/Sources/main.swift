import KituraRouter
import KituraNet
import KituraSys

let router = Router()

router.get("/entry") { request, response, next in 
    response.setHeader("Content-Type", value: "text/text; charset=utf-8")
    do {
        try response
            .status(HttpStatusCode.OK).send("Hello, world!").end()
    }
    catch {
        print("Response Error!")
    }
    next()
}
router.get("/") { request, response, next in 
    next()
}
let server = HttpServer.listen(8090, delegate: router)
Server.run()