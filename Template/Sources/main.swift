import KituraRouter
import KituraNet
import KituraSys
import Mustache
import Foundation // NSFileManager

let basePath = NSFileManager.defaultManager().currentDirectoryPath
let repository = TemplateRepository(directoryPath: basePath + "/Statics")
let router = Router()
router.get("/variable-expansion") { request, response, next in
    do {
        let template = try Template(string: "<h1>Hello, {{name}}!!</h1>")
        let data = ["name" : "World"]
        let boxedData = Box(data)
        let html = try template.render(boxedData)
        try response.status(HttpStatusCode.OK).send(html).end()
    } 
    catch {
    }
    next()
}

router.get("/dictionary-expansion") { request, response, next in
    do {
        let text = "{{#book}}"
            + "{{author}}, {{date}}, {{title}}"
            + "{{/book}}"
        let template = try Template(string: text)
        let data = [
            "book" : [
                "title" : "C Programming Language", 
                "author" : "Brian W. Ritchie, Dennis Kernighan", 
                "date" : "1988/3/22", 
            ]
        ]
        let boxedData = Box(data)
        let html = try template.render(boxedData)
        try response.status(HttpStatusCode.OK).send(html).end()
    } 
    catch {
    }
    next()
}

router.get("/array-expansion") { request, response, next in
    do {
        let text = "<html><ul>" 
            + "{{#links }}"
            + "<li><a href=\"{{link}}\">{{title}}</a></li>"
            + "{{/links }}"
            + "</ul></html>"
        let template = try Template(string: text)
        let data = [
            "links" : [
                ["title": "IBM", "link" : "http://ibm.com" ], 
                ["title": "Github", "link" : "https://github.com"], 
                ["title": "Qiita", "link" : "http://qiita.com"], 
            ]
        ]
        let boxedData = Box(data)
        let html = try template.render(boxedData)
        try response.status(HttpStatusCode.OK).send(html).end()
    } 
    catch {
    }
    next()
}

router.get("/conditional-branch") { request, response, next in
    do {
        let text =    "{{title}}" + "{{#showLink}} {{link}} {{/showLink}}"
        let template = try Template(string: text)
        let data = ["title" : "Hoge", "link" : "http://example.com", "showLink" : true]
        let boxedData = Box(data)
        let html = try template.render(boxedData)
        try response.status(HttpStatusCode.OK).send(html).end()
    } 
    catch {
    }
    next()
}

router.get("/") { request, response, next in
    do {
        let template = try repository.template(named: "layout")
        let data = [
            "title" : "KItura", 
            "content": [
                "header": "Web application framework Kitura", 
                "links" : [
                    ["title" : "Variable Expansion", "link" : "/variable-expansion"], 
                    ["title" : "Dictionary Expansion",  "link" : "/dictionary-expansion"], 
                    ["title" : "Array Expansion", "link" : "/array-expansion", ], 
                    ["title" : "Conditional Branch", "link" : "/conditional-branch", ], 
                ]
            ]
        ]
        let boxedData = Box(data)
        let html = try template.render(boxedData)
        try response.status(HttpStatusCode.OK).send(html).end()
    } 
    catch { }
    next()
}
let server = HttpServer.listen(8090, delegate: router)
Server.run()