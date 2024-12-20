let
	lock-false = {
		Value = false;
		Status = "locked";
	};
	lock-true = {
		Value = true;
		Status = "locked";
	};
in
{ config, pkgs, ... }: {
	programs = {
		firefox = {
			enable = true;
			languagePacks = [ "en-US" ];

			/* ---- POLICIES ---- */
			# Check about:policies#documentation for options.
			policies = {
				DisableTelemetry = true;
				DisableFirefoxStudies = true;
				EnableTrackingProtection = {
					Value= true;
					Locked = true;
					Cryptomining = true;
					Fingerprinting = true;
				};
				DisablePocket = true;
				#DisableFirefoxAccounts = true;
				#DisableAccounts = true;
				DisableFirefoxScreenshots = true;
				OverrideFirstRunPage = "";
				OverridePostUpdatePage = "";
				DontCheckDefaultBrowser = true;
				DisplayBookmarksToolbar = "always";
				DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
				SearchBar = "unified"; # alternative: "separate"

				/* ---- EXTENSIONS ---- */
				# Check about:support for extension/add-on ID strings.
				# Valid strings for installation_mode are "allowed", "blocked",
				# "force_installed" and "normal_installed".
				ExtensionSettings = with builtins;
				let extension = shortId: uuid: {
					name = uuid;
					value = {
						install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
						installation_mode = "normal_installed";
					};
				};
				in listToAttrs [
						(extension "ublock-origin" "uBlock0@raymondhill.net")
						(extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
				];
	
				/* ---- PREFERENCES ---- */
				# Check about:config for options.
				Preferences = { 
					"browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
					"extensions.pocket.enabled" = lock-false;
					"extensions.screenshots.disabled" = lock-true;
					"browser.topsites.contile.enabled" = lock-false;
					"browser.formfill.enable" = lock-false;
					"browser.search.suggest.enabled" = lock-false;
					"browser.search.suggest.enabled.private" = lock-false;
					"browser.urlbar.suggest.searches" = lock-false;
					"browser.urlbar.showSearchSuggestionsFirst" = lock-false;
					"browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
					"browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
					"browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
					"browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
					"browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
					"browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
					"browser.newtabpage.activity-stream.showSponsored" = lock-false;
					"browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
					"browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
				};
			};
		};
	};
}
