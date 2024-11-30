import boto3
import os
from datetime import datetime

TAG_KEY = os.getenv("TAG_KEY", "AutoSchedule")  # Tag key to filter instances
TAG_VALUE = os.getenv("TAG_VALUE", "True")  # Tag value to filter instances

ec2 = boto3.client("ec2")

def stop_instances():
    response = ec2.describe_instances(
        Filters=[
            {"Name": f"tag:{TAG_KEY}", "Values": [TAG_VALUE]},
            {"Name": "instance-state-name", "Values": ["running"]},
        ]
    )
    instances = [instance["InstanceId"] for reservation in response["Reservations"] for instance in reservation["Instances"]]
    if instances:
        ec2.stop_instances(InstanceIds=instances)
        print(f"Stopped instances: {instances}")
    else:
        print("No instances to stop.")

def start_instances():
    response = ec2.describe_instances(
        Filters=[
            {"Name": f"tag:{TAG_KEY}", "Values": [TAG_VALUE]},
            {"Name": "instance-state-name", "Values": ["stopped"]},
        ]
    )
    instances = [instance["InstanceId"] for reservation in response["Reservations"] for instance in reservation["Instances"]]
    if instances:
        ec2.start_instances(InstanceIds=instances)
        print(f"Started instances: {instances}")
    else:
        print("No instances to start.")

def lambda_handler(event, context):
    current_hour = datetime.now().hour
    if current_hour >= 17:  # After 5 PM
        stop_instances()
    elif current_hour >= 9 and current_hour < 17:  # Between 9 AM and 5 PM
        start_instances()
    else:
        print("Outside scheduled hours.")
