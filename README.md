# ckv-tests

Ensure you have installed [Checkov](https://www.checkov.io/2.Basics/Installing%20Checkov.html)

## Notes for creating custom Checkov policies and testing.  

#### If using this repo, please note for each folder I ran tests, you'll notice multiple yaml files for policies.  For each case, I always started small and then built it up, often times running into something that only partially worked.  However I didn't want to lose work, so I created new files and ran new tests, preserving each file.  In summary use the last file in each folder as what should have been my final working test.

### Test Policies locally:

Test policies locally with temp files.  for example:
```
checkov -f iam.tf --external-checks-dir policies --framework terraform -c POL1
```
- add optional `--compact` flag

### Contribution Instructions:
1. Use the appropriate doc after completing testing and ready to submit 
	1. YAML: https://www.checkov.io/6.Contribution/Contribute%20YAML-based%20Policies.html
	2. Python: https://www.checkov.io/6.Contribution/Contribute%20Python-Based%20Policies.html
2. Choose the next available CKV ID based on current docs and enter this in the id field in your policy check file:
		https://www.checkov.io/5.Policy%20Index/all.html
3. See [Running Tests](https://github.com/bridgecrewio/checkov/blob/main/CONTRIBUTING.md#running-tests) and follow the setup.  I followed the pipenv commands:    
```
pip install pipenv
pipenv install --dev
pipenv run python -m coverage run -m pytest tests
```
4. Perform final test before commit:
- Example for a yaml policy:    
```
pipenv run python -m coverage run -m pytest tests tests/terraform/graph/checks/test_yaml_policies.py
```
- Delete temp test files, commit, push to your Repo
5. Sync your fork if needed and create PR to checkov/master, following PR Comment instructions.
- Consider writing the same amount of detail as you would expect on the policy docs pages.  This will expedite the Checkov team in publishing docs for your policy.
6. NOTE: Policy gets added to index & checkov code version updated by team after PR is approved & merged 
7. After your PR is approved and merged, you can fetch upstream back to your main which pull your changes (as well as any other recent commits) back to your main.  Good article ref here about Fork & Branch Git workflow:
		https://blog.scottlowe.org/2015/01/27/using-fork-branch-git-workflow/


### Completed PRs for reference:
https://github.com/bridgecrewio/checkov/pull/3712
https://github.com/bridgecrewio/checkov/pull/3794


### Additional Reference Info

#### Docs I used to write my first policy:
1. Contributing (including Python & YAML instructions)
	-  https://www.checkov.io/6.Contribution/Contribution%20Overview.html
2. Custom Policy Writing
	-  https://www.checkov.io/3.Custom%20Policies/Custom%20Policies%20Overview.html
3. YAML Examples:
	-  https://docs.bridgecrew.io/docs/examples-yaml-based-custom-policies


#### Bridgecrew IAM Docs:
1. https://docs.bridgecrew.io/docs/iam-policies

#### JSONPath:
1. https://jsonpath.com/ - Evaluator
2. https://www.hcl2json.com/ - TF HCL to JSON
