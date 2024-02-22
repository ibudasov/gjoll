import logging
import json
from azure.core.credentials import AzureKeyCredential
from azure.eventgrid import EventGridPublisherClient, EventGridEvent

import azure.functions as func

def main(event: func.EventHubEvent):
  logging.info('Python EventHub trigger function processed an event: %s',
         event.get_body().decode('utf-8'))

  # Event Grid topic endpoint
  endpoint = "<event-grid-topic-endpoint>"
  # Event Grid topic key
  key = "<event-grid-topic-key>"

  # Create a publisher client
  credential = AzureKeyCredential(key)
  client = EventGridPublisherClient(endpoint, credential)

  # Create an Event Grid Event
  event_grid_event = EventGridEvent(
    subject="EventHub/Event",
    data={
      "message": event.get_body().decode('utf-8')
    },
    event_type="RecordInserted",
    data_version="1.0"
  )

  # Send the event
  client.send_events([event_grid_event])

  logging.info('Event sent to Event Grid.')