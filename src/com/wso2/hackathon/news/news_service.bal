
import ballerina.net.http;
import ballerina.data.sql;
import ballerina.lang.messages;
import ballerina.utils.logger;
import ballerina.lang.jsons;
import ballerina.lang.datatables;

@http:config { basePath: "/news"}
service<http> Service1 {
 
    @http:GET {}
    resource feed (message m) {
 
        map propertiesMap = {"jdbcUrl": "jdbc:mysql://localhost:3306/newsdb","username": "root","password": "root","maximumPoolSize": 1};
 
        sql:ClientConnector newsDB = create sql:ClientConnector   (propertiesMap);
        message response = {};
        string query = "SELECT * FROM news";
        sql:Parameter[] parameters = [];
        datatable dt = sql:ClientConnector.select(newsDB, query, parameters);
 
        var jsonRes,error = <json>dt;
 
        string s = jsons:toString(jsonRes);
        logger:info(s);
        messages:setJsonPayload(response,jsonRes);
        datatables:close(dt);

        reply response;
    }

    @http:POST {}
    resource dataservice (message m) {
        reply m;
    }
}
