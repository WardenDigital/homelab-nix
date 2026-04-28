{ ... }:
{
  programs.nvf.settings.vim.luaConfigPost = ''
        vim.api.nvim_create_user_command("ToAWS", function()
            local path = vim.fn.expand("%")
            local command = "translator -out same -dict ~/Projects/work/dictionary.json " .. path
            local jobid = vim.fn.jobstart(command)
            vim.fn.jobwait({ jobid })
            vim.fn.execute(":e")
        end, {})

        vim.api.nvim_create_user_command("ToLocal", function()
            local path = vim.fn.expand("%")
            local command = "translator -target local -out same -dict ~/Projects/work/dictionary.json " .. path
            local jobid = vim.fn.jobstart(command)
            vim.fn.jobwait({ jobid })
            vim.fn.execute(":e")
        end, {})

        vim.api.nvim_create_autocmd('TextYankPost', {
            desc = "Highlight yanked text",
            group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
            callback = function()
                vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
            end,
        })

        vim.api.nvim_create_user_command("CpPath", function()
    	    local path = vim.fn.expand("%")
    	    vim.fn.setreg("+", path)
    	    vim.notify('Copied "' .. path .. '" to the clipboard!')
        end, {})
        
        vim.api.nvim_create_user_command("CpFPath", function()
        	local path = vim.fn.expand("%:p")
        	vim.fn.setreg("+", path)
        	vim.notify('Copied "' .. path .. '" to the clipboard!')
        end, {})
  '';
}
