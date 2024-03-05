module Parser
  # tokenize structure from string
  def parse_structure_token(tokens)
    current_spaces = 0
    current_paths = []
    paths = []
    push_path_helper = lambda { |token|
      if token[:type] == 'dir'
        current_paths.push(token[:name])
      else
        paths.push([current_paths.dup, token[:name]])
      end
    }
    tokens.each do |token|
      token[:count] < current_spaces && (current_spaces - token[:count]).times { current_paths.pop }
      current_spaces = token[:count]
      push_path_helper.call(token)
    end
    paths
  end
end
