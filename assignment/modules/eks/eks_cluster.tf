resource "aws_eks_cluster" "eks-cluster" {
  name     = "${local.name_suffix}-eks-cluster"
  role_arn = aws_iam_role.eks-cluster-iam.arn
  vpc_config {
    security_group_ids = [aws_security_group.eks-cluster-sg.id]
    subnet_ids         = var.private_subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
  ]
  tags   = merge(local.common_tags, { "Name" = "${local.name_suffix}-eks-cluster" })
}


#EKS Cluster node group
# Nodes in private subnet
resource "aws_eks_node_group" "eks_node_group_private" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "${local.name_suffix}-eks-node-group-private"
  node_role_arn   = aws_iam_role.eks-cluster-node-iam.arn
  subnet_ids      = var.private_subnet_ids
  ami_type        = var.ami_type
  disk_size       = var.disk_size
  instance_types  = var.eks_nodegroup_instance_types

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  tags   = merge(local.common_tags, { "Name" = "${local.name_suffix}-eks-cluster-eks-node-group-private" })

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-cluster-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-cluster-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
