import org.wso2.ballerina.connectors.gmail;
import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.net.http;
import ballerina.lang.jsons;

string deleteResponse = {};

string accessToken="ya29.-6Z3PKBtqE-Xt0GeFy0rvENSoiPYGHX";
string refreshToken = "apps.googleusercontent.com";

string userId = "lahirugmg@gmail.com";
string recipientAddress = "lahirus@wso2.com";

function main (string[] args) {

    message gmailResponse = {};
    json gmailJSONResponse = {};
    gmailResponse = sendNewsMails ();
    gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    system:println(jsons:toString(gmailJSONResponse));

}

function init () (gmail:ClientConnector gmailConnector) {
    gmailConnector = create gmail:ClientConnector(userId,accessToken,refreshToken,"","");
    return;
}

function sendNewsMails () (message) {
    string to = recipientAddress;
    string subject = "Test subject 1";
    string from = userId;
    string messageBody = "Test message 1";
    string cc = userId;
    string bcc = userId;
    string id = "154b8c77e551c511";
    string threadId = "154b8c77e551c512";
    gmail:ClientConnector connectorInstance = init();
    message gmailResponse = gmail:ClientConnector.sendMail (connectorInstance, to, subject, from, messageBody
                                                            , cc, bcc, id, threadId);
    //json gmailJSONResponse = messages:getJsonPayload(gmailResponse);
    string statusCode = <string>http:getStatusCode(gmailResponse);
    return gmailResponse;
}
