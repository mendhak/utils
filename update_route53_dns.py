# coding:utf-8

import urllib2
import boto
from boto.route53.connection import Route53Connection
from boto.route53.record import ResourceRecordSets
import time

if __name__ == '__main__':

    R53_ZONEID = "Z3H1J7NXRY8WVM"
    R53_DOMAIN = "pi.mendhak.com"

    zones = {}
    route53 = Route53Connection()
    recordsets = route53.get_all_rrsets(R53_ZONEID, type='A', name=R53_DOMAIN, maxitems=1)

    new_ip_address = urllib2.urlopen('http://icanhazip.com').read()
    new_ip_address = new_ip_address.replace("\n","")

    if recordsets and recordsets[0].name == R53_DOMAIN + '.' and recordsets[0].resource_records:
        print "Found existing recordset."
        old_ip_address = recordsets[0].resource_records[0]
        print "Old IP address: " + old_ip_address
        changes = ResourceRecordSets(route53, R53_ZONEID)
        change = changes.add_change("DELETE", R53_DOMAIN, "A")
        change.add_value(old_ip_address)
        print "Deleting..."
        result = changes.commit()
        time.sleep(10)

    print "Creating new recordset"
    changes2 = ResourceRecordSets(route53, R53_ZONEID)
    change2 = changes2.add_change("CREATE", R53_DOMAIN, "A")
    print "New IP address:" + new_ip_address
    change2.add_value(new_ip_address)
    print "Saving..."
    result = changes2.commit()
