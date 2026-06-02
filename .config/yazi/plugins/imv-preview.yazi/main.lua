local M = {}

function M:peek(job)
	-- Start imv in the background, targeting the currently hovered file path
	local child, err = Command("imv"):arg(tostring(job.file.url)):spawn()

	if not child then
		ya.err("Failed to start imv preview: " .. tostring(err))
	end
end

function M:seek(job)
	-- Leave empty; needed by Yazi's plugin structure
end

return M
