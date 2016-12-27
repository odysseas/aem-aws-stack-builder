#!/usr/bin/env bash

INVENTORY=$1

# TODO: should log the output for investigation and debugging if required.

ansible-playbook -vvv ansible/chaos-monkey.yaml -i "ansible/$INVENTORY" --tags delete &
ansible-playbook -vvv ansible/orchestrator.yaml -i "ansible/$INVENTORY" --tags delete &
ansible-playbook -vvv ansible/author-dispatcher.yaml -i "ansible/$INVENTORY" --tags delete &
ansible-playbook -vvv ansible/author.yaml -i "ansible/$INVENTORY" --tags delete &
ansible-playbook -vvv ansible/publish.yaml -i "ansible/$INVENTORY" --tags delete &
ansible-playbook -vvv ansible/publish-dispatcher.yaml -i "ansible/$INVENTORY" --tags delete &

wait

ansible-playbook -vvv ansible/messaging.yaml -i "ansible/$INVENTORY" --tags delete &
ansible-playbook -vvv ansible/security-groups.yaml -i "ansible/$INVENTORY" --tags delete &

wait
echo Finished Deleting AEM Stack
