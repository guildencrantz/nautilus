1. Create `neptune-remote.yaml` in your home directory
    ```yaml
    hosts: ["efd-dev-jules-verne.cluster-c9fu3ayt4gln.us-east-1.neptune.amazonaws.com"]
    port: 8182
    connectionPool: {
      channelizer: org.apache.tinkerpop.gremlin.driver.SigV4WebSocketChannelizer}
    serializer: { className: org.apache.tinkerpop.gremlin.driver.ser.GryoMessageSerializerV3d0, config: { serializeResultToString: true }}
    ```
2. `docker run --rm -it -v $HOME:$HOME -e HOME -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY guildencrantz/nautilus`
    1. `:remote connect tinkerpop.server /home/${YOUR USERNAME HERE}/neptune-remote.yaml`
    2. `:remote console`

