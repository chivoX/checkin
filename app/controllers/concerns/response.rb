# frozen_string_literal: true

module Response
  def json_response(object, status = :ok)
    response_object = if object.is_a?(Hash)
                        object
                      else
                        (object.class.name + 'Serializer').constantize.new(object).serialized_json
                      end
    render json: response_object, status: status
  end
end
