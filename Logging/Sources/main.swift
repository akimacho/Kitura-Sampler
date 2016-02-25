import KituraSys
import KituraNet
import KituraRouter
import LoggerAPI
import HeliumLogger

let router = Router()
Log.logger = HeliumLogger()
router.get("/") { request, response, next in
     Log.debug("This is debug log!")
     Log.verbose("This is verbose log!")
     Log.info("This is info log!")
     Log.warning("This is warning log!")
     Log.info("This is error log!")
     next()
}
let server = HttpServer.listen(8090, delegate: router)
Server.run()