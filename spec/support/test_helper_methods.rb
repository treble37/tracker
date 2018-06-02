def serialize_task_resource(resource)
  ActiveModelSerializers::SerializableResource.new(
    resource, each_serializer: V1::TaskSerializer
  ).as_json
end
