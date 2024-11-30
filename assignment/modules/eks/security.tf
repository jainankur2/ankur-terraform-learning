resource "aws_security_group" "eks-cluster-sg" {
  name        = "${local.name_suffix}-eks-cluster-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags   = merge(local.common_tags, { "Name" = "${local.name_suffix}-eks-cluster-sg" })
}

resource "aws_security_group_rule" "eks-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-cluster-sg.id
  source_security_group_id = aws_security_group.eks-cluster-node-sg.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-cluster-sg.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "eks-cluster-ingress-traffic" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 0
  protocol          = -1
  security_group_id = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id
  to_port           = 0
  type              = "ingress"
  depends_on        = [aws_eks_cluster.eks-cluster]
}

# Node group security group
resource "aws_security_group" "eks-cluster-node-sg" {
  name        = "${local.name_suffix}-eks-cluster-node-sg"
  description = "Security group for all nodes in the cluster"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags   = merge(local.common_tags, { "Name" = "${local.name_suffix}-eks-cluster-node-sg" })
}

resource "aws_security_group_rule" "eks-cluster-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks-cluster-node-sg.id
  source_security_group_id = aws_security_group.eks-cluster-node-sg.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-cluster-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-cluster-node-sg.id
  source_security_group_id = aws_security_group.eks-cluster-sg.id
  to_port                  = 65535
  type                     = "ingress"
}
