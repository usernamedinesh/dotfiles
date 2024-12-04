#/run/current-system/sw/bin/zsh
i3-msg -t get_tree | jq -r '
  .nodes[].nodes[].nodes[] | 
  select(.type=="workspace") | 
  {name: .name, windows: [.nodes[].name, .floating_nodes[].name] | add } |
  "\(.name): \(.windows)"
'
