# Change Log

## [Unreleased](https://github.com/decidim/decidim/tree/HEAD)

**Upgrade notes**:

**Added**:

**Changed**:

- **decidim-core**: Show the number of followers when the button "follow" appears. [\#5593](https://github.com/decidim/decidim/pull/5593)
- **decidim-proposals, decidim-debates and decidim-initiatives**: Improved visiblity of buttons: new proposal, debate and initiative. [\#5535](https://github.com/decidim/decidim/pull/5535)
- **decidim-proposals**: Add a filter "My proposals" at the list of proposals. [\#5512](https://github.com/decidim/decidim/pull/5512)
- **decidim-meetings**: Change: @meetings_spaces collection to use I18n translations [#5494](https://github.com/decidim/decidim/pull/5494)
- **decidim-core**: Add @ prefix to the nickname field in the registration view. [\#5482](https://github.com/decidim/decidim/pull/5482)
- **decidim-core**: Introduce the ActsAsAuthor concern. [\#5482](https://github.com/decidim/decidim/pull/5482)
- **decidim-core**: Extract footers into partials. [#5461](https://github.com/decidim/decidim/pull/5461)
- **decidim-initiatives**: UX improvements to initiatives [#5369](https://github.com/decidim/decidim/pull/5369)
- **decidim-core**: Update to JQuery 3 [#5433](https://github.com/decidim/decidim/pull/5433)
- **decidim_participatory_process**: Admin: move `:participatory_process_groups` from `:main_menu` to `:participatory_processes` `:secondary_nav`[#5545](https://github.com/decidim/decidim/pull/5545)
- **decidim-core**: Remove the Continuity badge [#5565](https://github.com/decidim/decidim/pull/5565)
- **decidim-core**: Remove resizing for banner images [#5567](https://github.com/decidim/decidim/pull/5567)

**Fixed**:

- **decidim-core**: Fix: Apply google webmaster guidelines for buttons "sign with Google".[\#5592](https://github.com/decidim/decidim/pull/5592)
- **decidim-conferences**: Fix: Cluttered conference sessions in confirmation mail.[\#5524](https://github.com/decidim/decidim/pull/5524)
- **decidim-core**: Security upgrade: puma. [\#5556](https://github.com/decidim/decidim/pull/5556)
- **decidim-admin**: Fix: Edit component permissions when PermissionsForm validations fail [\#5458](https://github.com/decidim/decidim/pull/5458)
- **decidim-core**: Security upgrade: rack-cors. [\#5527](https://github.com/decidim/decidim/pull/5527)
- **decidim-core**, **decidim-proposals**: Fix: diffing attributes with integer values [\#5468](https://github.com/decidim/decidim/pull/5468)
- **decidim-consultations**: Fix: current_participatory_space raises error in ConsultationsController.[\#5513](https://github.com/decidim/decidim/pull/5513)
- **decidim-admin**: Admin HasAttachments forces the absolute namespace for the AttachmentForm to `::Decidim::Admin::AttachmentForm`.[\#5511](https://github.com/decidim/decidim/pull/5511)
- **decidim-participatory_processes**: Fix participatory process import when some imported elements are null [\#5496](https://github.com/decidim/decidim/pull/5496)
- **decidim-core**: Security upgrade: loofah. [\#5493](https://github.com/decidim/decidim/pull/5493)
- **decidim-core**: Fix: misspelling when selecting the meetings presenter. [\#5482](https://github.com/decidim/decidim/pull/5482)
- **decidim-core**, **decidim-participatory_processes**: Fix: Duplicate results in `Decidim::HasPrivateUsers::visible_for(user)` [\#5462](https://github.com/decidim/decidim/pull/5462)
- **decidim-participatory_processes**: Fix: flaky test when mapping Rails timezone names to PostgreSQL [\#5472](https://github.com/decidim/decidim/pull/5472)
- **decidim-conferences**: Fix: Add pagination interface to some sections [\#5463](https://github.com/decidim/decidim/pull/5463)
- **decidim-sortitions**: Fix: Don't include drafts in sortitions [\#5434](https://github.com/decidim/decidim/pull/5434)
- **decidim-assemblies**: Fix: Fixed assembly parent_id when selecting itself [#5416](https://github.com/decidim/decidim/pull/5416)
- **decidim-core**: Fix: Search box on mobile (menu) [#5502](https://github.com/decidim/decidim/pull/5502)
- **decidim-core**: Fix dynamic controller extensions (undefined method `current_user`) [#5533](https://github.com/decidim/decidim/pull/5533)
- **decidim-proposals**: Standardize proposal answer callout styles [#5530](https://github.com/decidim/decidim/pull/5530)

**Removed**:

## Previous versions

Please check [0.20-stable](https://github.com/decidim/decidim/blob/0.19-stable/CHANGELOG.md) for previous changes.
