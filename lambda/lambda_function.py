import boto3
import datetime
import os

ec2 = boto3.client('ec2')
sns = boto3.client('sns')

def lambda_handler(event, context):
    snapshots = ec2.describe_snapshots(OwnerIds=['self'])['Snapshots']
    
    deleted = []
    now = datetime.datetime.now(datetime.timezone.utc)

    for snap in snapshots:
        start_time = snap['StartTime']
        age_minutes = (now - start_time).total_seconds() / 60

        if age_minutes > 1:
            ec2.delete_snapshot(SnapshotId=snap['SnapshotId'])
            deleted.append(snap['SnapshotId'])

    message = ""

    if deleted:
        message = "Deleted Snapshots:\n" + "\n".join(deleted)
    else:
        message = "No snapshots deleted"

    print(message)  # for logs

    sns.publish(
        TopicArn=os.environ['SNS_TOPIC_ARN'],
        Subject="Snapshot Cleanup Report",
        Message=message
    )

    return message