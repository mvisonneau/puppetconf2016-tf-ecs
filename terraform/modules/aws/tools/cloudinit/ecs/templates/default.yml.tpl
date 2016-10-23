#cloud-config
locale: en_US.UTF-8
timezone: UTC
runcmd:
  - echo ECS_CLUSTER=${cluster_name} > /etc/ecs/ecs.config
  - echo ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION=30m >> /etc/ecs/ecs.config
final_message: "The system is finally up, after $UPTIME seconds"
