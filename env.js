var clusters = [
    {
      NAME:"prod", //Required
      KAFKA_CONNECT: "http://kafka-connect.url", //Required
      KAFKA_TOPICS_UI: "http://kafka-topics-ui.url", //Optional
      KAFKA_TOPICS_UI_ENABLED: true, //Optional
      COLOR: "#141414" // Optional
 
    },
    {
      NAME:"dev",
      KAFKA_CONNECT: "https://kafka-connec.dev.url",
      KAFKA_TOPICS_UI_ENABLED: false
    },
    {
      NAME:"local",
      KAFKA_CONNECT: "http://localhost:8083"
    }
 ]
   