import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.net.jms;
import ballerina.doc;
import ballerina.lang.jsons;

@doc:Description{value : "This service will consume news as bulk "}
@jms:config {
    connectionFactoryType:"topic",
    connectionFactoryName:"TopicConnectionFactory",
    destination:"news-delivery",
    acknowledgmentMode:"AUTO_ACKNOWLEDGE"
,
    providerUrl:"tcp://localhost:61616",
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory"}

service<jms> jmsService {
    resource onMessage (message m) {

        json jsonPayload = messages:getJsonPayload(m);


        int arrayLength = jsons:getInt(jsonPayload, "$.length()");
        int i = 0;
        
        while (i < arrayLength) {
            json e = jsonPayload[i];
            system:println("Each news: ");
            system:println(e);
            i = i + 1;
            
            
        }
        
        
    }
}