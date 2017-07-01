import ballerina.lang.messages;
import ballerina.lang.system;
import ballerina.net.jms;
import ballerina.doc;

@doc:Description{value : "This service will consume news as bulk "}
@jms:config {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryType:"topic",
    connectionFactoryName:"TopicConnectionFactory",
    destination:"news-delivery",
    acknowledgmentMode:"AUTO_ACKNOWLEDGE"
}

service<jms> jmsService {
    resource onMessage (message m) {

        // Retrieve the string payload using native function.
        string stringPayload = messages:getStringPayload(m);

        // Print the retrieved payload.
        system:println("Payload: " + stringPayload);
    }
}