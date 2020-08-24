# Introduction

This is a proof of concept CA rotation project to complement the Kafka Summit Talk titled _Securing Kafka at Zendesk_ that I gave at Kafka Summit 2020


# Dependencies

To be able to run this project you will need `docker` and `docker-compose` installed in your computer.

You will also need to have Terraform installed. There's a `.terraform-version` file at `terraform` folder, I would recommend
using [Terraform Version Manager](https://github.com/tfutils/tfenv), once `tfenv` is installed you can run `tfenv install` to install
the required version of terraform.


# How to run

1. Start `vault` and `consul`
   with
   
    ```
   	 docker-compose up 
    ```
    
    You can now head over to [http://127.0.0.1:8200](http://127.0.0.1:8200), the password is set to `root`, you can login and wander around
    the UI. You can check consul at [http://127.0.0.1:8500](http://127.0.0.1:8200).
    
    In one terminal tab, tail logs of the `consul-template` service with:
    
    ```
    docker-compose logs -f consul_template
    ```
    
2. Initialise the terraform project and apply with the following:

   ```
   cd terraform
   terraform init
   terraform apply
   ```
   
   Keep an eye on `consul-template` logs, you will soon see it has generated a service certificate from the current root (Root A).
   
   

You can at this point follow the demo from the talk to introduce a new root (Root B), then swap the roots while inspecting the logs of `consul-template` to verify it's following along the changes in the `consul` key. Or you can also continue following along.

3. Introduce new root (`Root B`)
  I have added the necessary code for adding a new root, so you can just do the following

  ```
  git checkout introduce-new-root-b
  terraform apply # type yes when prompted
  ```
  
  As soon as you press enter, you should notice consul-template regenerating certificates on the logs.

4. Now to we can swap the roots using the following commands

  ```
  git checkout swap-roots
  terraform apply # type yes when prompted
  ```

  You will see consul-template regenerating the service certificate from new root, Root B.

5. Now we can remove the old root from the list of secondary issuers.
  
  ```
  git checkout remove-old-root-from-secondary-issuers
  terraform apply # type yes when prompted
  ```

  
6. We can also now remove root-a from vault

  ```
  git checkout remove-old-root-from-vault
  terraform apply # type yes when prompted
  ```

Feel free to raise PRs or issues if you have questions/comments/anything to add.
