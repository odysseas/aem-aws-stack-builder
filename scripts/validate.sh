#!/usr/bin/env bash

CLOUDFORMATION_TEMPLATES="$PWD/templates/*/*.yaml"

for template in $CLOUDFORMATION_TEMPLATES
do

	echo "Validating CloudFormation Template - $template"
	aws cloudformation validate-template --template-body "file:///$template"

done


ANSIBLE_PLAYBOOKS="$PWD/ansible/*.yaml"

for playbook in $ANSIBLE_PLAYBOOKS
do

	echo "Check Ansible Playbook Syntax - $playbook"
	ansible-playbook -vvv "$playbook" --syntax-check

done