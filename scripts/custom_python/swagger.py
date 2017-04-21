import requests
import yaml
import json


def create_aggregator(config):
    url = "http://localhost:8080/repox/rest/aggregators"
    headers = {'content-type': 'application/json'}
    r = requests.post(url, data=json.dumps(config["Aggregator"]), auth=(config["Authorization"]["username"], config["Authorization"]["password"]), headers=headers)
    if r.status_code == 201:
        print("Successfully created aggregator.")
    elif r.status_code == 409:
        print("Could not create aggregator. It already exists.")
    else:
        print("There was a problem creating your aggregator.")


def create_provider(config, provider):
    url = "http://localhost:8080/repox/rest/providers?aggregatorId={0}".format(provider['aggregator_id'])
    headers = {'content-type': 'application/json'}
    print(provider["provider"])
    r = requests.post(url, data=json.dumps(provider["provider"]), auth=(config["Authorization"]["username"], config["Authorization"]["password"]), headers=headers)
    if r.status_code == 201:
        print("Successfully created provider.")
    elif r.status_code == 409:
        print("Provider already exists!")
    else:
        print(r.status_code)


def create_oai_set(config, oaiset):
    url = "http://localhost:8080/repox/rest/datasets?providerId={0}".format(oaiset["providerId"])
    headers = {'content-type': 'application/json'}
    r = requests.post(url, data=json.dumps(oaiset["set"]), auth=(config["Authorization"]["username"], config["Authorization"]["password"]), headers=headers)
    if r.status_code == 201:
        print("Successfully created set: {0}".format(oaiset["set"]["dataSource"]["id"]))
    elif r.status_code == 409:
        print("Set already exists!")
    else:
        print(r.status_code)


def harvest_set(set, config):
    url = "http://localhost:8080/repox/rest/datasets/{0}/harvest/start?type=full".format(set)
    r = requests.post(url, auth=(config["Authorization"]["username"], config["Authorization"]["password"]))
    if r.status_code == 200:
        print("Successfully harvested set: {0}".format(set))
    else:
        print(r.status_code)


if __name__ == "__main__":
    settings = yaml.load(open('../../config-files/config_data.yml', 'r'))
    create_aggregator(settings)
    for p in settings["Providers"]:
        create_provider(settings, p)
    for set in settings["Sets"]:
        create_oai_set(settings, set)
        harvest_set(set["set"]["dataSource"]["id"], settings)
