local cmp = require('cmp')
local chat = require('CopilotChat')

local Source = {}

function Source:get_trigger_characters()
  return { '@', '/' }
end

function Source:complete(params, callback)
  local items = {}
  local prompts_to_use = chat.prompts()

  if params.completion_context.triggerCharacter == '/' then
    for name, _ in pairs(prompts_to_use) do
      items[#items + 1] = {
        label = '/' .. name,
      }
    end
  else
    items[#items + 1] = {
      label = '@buffers',
    }

    items[#items + 1] = {
      label = '@buffer',
    }
  end

  callback({ items = items })
end

local M = {}

--- Setup the nvim-cmp source for copilot-chat window
function M.setup()
  cmp.register_source('copilot-chat', Source)
  cmp.setup.filetype('copilot-chat', {
    sources = {
      { name = 'copilot-chat' },
    },
  })
end

return M
