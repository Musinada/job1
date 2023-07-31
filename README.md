# terraform job1: 
Ec2 -Iac-automation
EKS - automation



IAAC Automation using Terraform:


EC2 : 
steps to do;
1. ec2 machine

2. vpc creation


3. create a subnet

4. create a igw.

5. create a route table

6. in route table keep the gateway_id with igw (created)
7. association of subnet with route table

8. security group for linux machine - ingress and egress tcp : porting

9. variables for all needed resources

10. outputs for the resources.

######################################################################################################


EKS Cluster:
steps to do;
1. iam role for "masternode", here service="eks.amazonaws.com"

2. attach the policies for 'master'.
   such as AmazonEKSClusterPolicy, AmazonEKSServicePolicy, AmazonEKSVPCResourceController.

3. iam role for "workernode", here service=eks.amazonaws.com

4. add iam policy - "autoscalar"

5. attach the policies for 'worker'.
   such as, AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy, AmazonSSMManagedInstanceCore, AmazonEC2ContainerRegistryReadOnly, x-ray, s3, "autoscaler" (created one), resource "aws_iam_instance_profile" "worker".

6. eks_cluster creation - use the created iam role - master


7. eks_node_group - use the created iam role - worker.
here specify the scalling configuration desigred-1, max-2, min-1.


8. create variable.tf and attach required resources like sg_ids, subnet_ids, vps_id

9. create output.tf, here add the end point for value: "aws_eks_cluster.eks.endpoint"


########################################################################################################

Security_Group for EKS_Cluster:
steps to do; 
1. create a resource for "worker_node_sg", that will allows traffic by keeping ingress(ssh), egress.
   
2. output

3. variables

++++++++++++++++++++++++++++++Thankyou_++++++++++++++++++++++++++++++++++++++++++++++++++++
