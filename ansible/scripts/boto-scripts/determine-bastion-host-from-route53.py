#!/usr/bin/env python

import sys
import boto3

try:
    env = sys.argv[1]
except IndexError:
    raise EnvironmentError("Excepted valid input e.g. dev, ppe etc and env type e.g. blue or green")

r53client = boto3.client('route53')
response = r53client.list_resource_record_sets(HostedZoneId='Z14K2XS4F5D7S8',StartRecordName='openvpn.javallejos.com',StartRecordType='A')['ResourceRecordSets'][0]['ResourceRecords'][0]['Value']
print response