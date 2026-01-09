/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 658 (329 per locale)
///
/// Built on 2026-01-08 at 10:19 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	zh(languageCode: 'zh', build: _StringsZh.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	String get k_0fdrjph => 'Event callback';
	String get k_15b7vxl => 'Basic module';
	String get k_1f157p5 => 'Initialize SDK';
	String get k_06n8uqh => 'Initialize SDK';
	String get k_05a3xy6 => 'Add event listener';
	String get k_1opua40 => 'Add an event listener before adding a login method to avoid missing messages';
	String get k_0ptv10l => 'Get server time';
	String get k_02r2v09 => 'Get server time by SDK';
	String get k_003r6vf => 'Log in';
	String get k_0z9427p => 'SDK login API. Initialize the SDK first.';
	String get k_003ph6s => 'Log out';
	String get k_1wu4tcs => 'Send C2C text message (disused since v3.6)';
	String get k_1t6awxa => 'Send C2C custom message (disused since v3.6)';
	String get k_0pwzyvl => 'Send group text message (disused since v3.6)';
	String get k_1ntp677 => 'Send group custom message (disused since v3.6)';
	String get k_1j35r5o => 'Get SDK version';
	String get k_0kt7otn => 'Get current login user';
	String get k_1v7brb7 => 'Get current login status';
	String get k_0x1tylx => 'Get user info';
	String get k_0elsjm2 => 'Create group chat';
	String get k_0elrwzy => 'Join group chat';
	String get k_0elt2dt => 'Quit group chat';
	String get k_0em2iiz => 'Delete group chat';
	String get k_0qq6zvv => 'Set personal profile';
	String get k_11deha5 => 'Experimental API';
	String get k_15a012s => 'Conversation module';
	String get k_1xdajb0 => 'Get conversation list';
	String get k_1rgdedc => 'Get conversation details';
	String get k_0glns86 => 'Delete conversation';
	String get k_0xzd96m => 'Set conversation as draft';
	String get k_0dg9tmi => 'Pin conversation to top';
	String get k_1vmox4p => 'Get conversation\'s total message unread count';
	String get k_15b6qz8 => 'Message module';
	String get k_1yns1w9 => 'Send text message';
	String get k_0zq67yj => 'Send custom message';
	String get k_1um4zaj => 'Send image message';
	String get k_0bgy5ol => 'Send video message';
	String get k_05gsxdv => 'Send file message';
	String get k_0axzzec => 'Send voice message';
	String get k_02blxws => 'Send text @ message';
	String get k_1um3h9j => 'Send geographical location message';
	String get k_1x28z5r => 'Send emoji message';
	String get k_0310ebw => 'Send combined message';
	String get k_00afgq7 => 'Send forward message';
	String get k_13sdbcu => 'Resend message';
	String get k_12w209p => 'Modify local message (string)';
	String get k_199jsqj => 'Modify local message (int)';
	String get k_0ktebqj => 'Modify cloud message (string; disused)';
	String get k_0k6jqud => 'Get C2C message history';
	String get k_0bf7otk => 'Get group message history';
	String get k_1fbo5v2 => 'Get message history (advanced API)';
	String get k_1asy1yf => 'Get message history (advanced API; unformatted)';
	String get k_13sdxko => 'Recall message';
	String get k_1vlsgoe => 'Mark C2C message as read';
	String get k_17fh8gz => 'Mark group message as read';
	String get k_16sb1e7 => 'Mark all messages as read';
	String get k_01q04pm => 'Delete local message';
	String get k_13sqfye => 'Delete message';
	String get k_1saxzrf => 'Insert local message to group chat';
	String get k_075u68x => 'Insert local message to C2C chat';
	String get k_16tukku => 'Clear local and cloud C2C message history';
	String get k_13z9nvj => 'Get user message receiving option';
	String get k_182b8ni => 'Clear local and cloud group message history';
	String get k_01qv9eo => 'Search for local messages';
	String get k_0bfyrre => 'Query local messages in a specified conversation';
	String get k_0mz8nlf => 'Friend relationship chain module';
	String get k_10ig2ml => 'Get friend list';
	String get k_0q5feak => 'Get friend info';
	String get k_16758qw => 'Add friend';
	String get k_0q5kkj1 => 'Set friend info';
	String get k_1666obb => 'Delete friend';
	String get k_167fad4 => 'Check friend';
	String get k_15gn1d5 => 'Get friend request list';
	String get k_05576s4 => 'Accept friend request';
	String get k_055cno8 => 'Reject friend request';
	String get k_0m517oy => 'Get blocklist';
	String get k_042sv53 => 'Add to blocklist';
	String get k_1oybli5 => 'Remove from blocklist';
	String get k_05jmpkg => 'Create friend list';
	String get k_05jnyuo => 'Get friend list';
	String get k_05jcbyt => 'Delete friend list';
	String get k_14xxze4 => 'Rename friend list';
	String get k_14kqmvu => 'Add friend to friend list';
	String get k_00mp87q => 'Remove friend from friend list';
	String get k_167cp0t => 'Search for friend';
	String get k_15b6vqr => 'Group module';
	String get k_1j2fn17 => 'Create group (advanced)';
	String get k_16mti73 => 'Get group joining request list';
	String get k_0suniq6 => 'Get group info';
	String get k_0supwn3 => 'Set group info';
	String get k_1ojrrgd => 'Get online group member count';
	String get k_1pb3f1z => 'Get group member list';
	String get k_1gx3i86 => 'Get group member info';
	String get k_1gwzvg7 => 'Set group member info';
	String get k_0h1ttfs => 'Mute group member';
	String get k_0c9tkhn => 'Invite friend to group';
	String get k_11yzdz7 => 'Remove member from group';
	String get k_0uupir5 => 'Set group role';
	String get k_18pxx1p => 'Transfer group owner';
	String get k_0r4h8ww => 'Search for group list';
	String get k_0h1m7ef => 'Search for group member';
	String get k_15az05y => 'Signaling module';
	String get k_0gzsnbo => 'Send invitation';
	String get k_1ifjitt => 'Send invitation in group';
	String get k_0qr6nnz => 'Get signaling info';
	String get k_0hsgjrg => 'Add invitation signaling';
	String get k_1499er2 => 'Add invitation signaling (triggered by group offline push messages)';
	String get k_1rmuiim => 'Offline push module';
	String get k_1uobs68 => 'Report push configuration';
	String get k_18ufun0 => 'Register event';
	String get k_0dyrkl5 => 'Deregister simpleMsgListener event';
	String get k_1q2xs9c => 'Deregister all simpleMsgListener events';
	String get k_0fyg1xs => 'Deregister advanceMsgListener event';
	String get k_0awkp15 => 'Deregister all advanceMsgListener events';
	String get k_12oryz1 => 'Deregister signalingListener event';
	String get k_1xb912c => 'Deregister all signalingListener events';
	String get k_1ec07ke => 'Friend ID';
	String get k_14bwl8c => 'Friend remarks';
	String get k_121555d => 'Friend list';
	String get k_0qbtor0 => 'Friend list, which must exist';
	String get k_0gavw6m => 'Add remarks';
	String get k_15ihgoz => 'Friend type';
	String get k_1675qge => 'Two-way friend';
	String get k_1675qk7 => 'One-way friend';
	String get k_1eopfpu => 'Select priority';
	String get k_03c51e7 => 'Not selected';
	String get k_0ethd0p => 'Add signaling info (select existing signaling info to test)';
	String get k_15i526p => 'Delete type';
	String get k_1ciwziu => 'Agree to add as two-way friend';
	String get k_19iuz0v => 'Agree to add as one-way friend';
	String get k_0ix65gm => 'Select friend type to agree';
	String get k_0gw88si => 'Accept request';
	String get k_0xxojzb => 'Received event callback';
	String get k_0quw2i5 => 'Select only one option';
	String get k_002r2pl => 'Single-choice';
	String get k_002r1h2 => 'Multiple-choice';
	String get k_002v9zj => 'OK';
	String get k_003nevv => 'Cancel';
	String get k_03mgr50 => 'Add the friend in the friend relationship chain module first';
	String get k_1ic4dp6 => 'Select friend on blocklist';
	String get k_161zzkm => 'Enter username';
	String get k_00alow4 => 'Call the experimental API for initializing local database (you can also call another API in the SDK)';
	String get k_1xogzdp => 'Call experimental API';
	String get k_15ijita => 'Check type';
	String get k_0y8ersu => 'Select check type';
	String get k_0iilkht => 'Clear local and cloud C2C message history (without deleting the conversation)';
	String get k_0szs46i => 'Get group information';
	String get k_0hqslym => 'No conversation information available';
	String get k_0gmqf8i => 'Select conversation';
	String get k_03eu3my => 'List name';
	String get k_03768rw => 'Group ID';
	String get k_1vjwjey => '(Optional) Enter a custom group ID';
	String get k_03agq58 => 'Group name';
	String get k_0kg1wsx => 'Select a group type';
	String get k_0lzvumx => 'Work';
	String get k_0mbokjw => 'Public';
	String get k_028lr1o => 'Meeting';
	String get k_1te7y0e => 'AVChatRoom';
	String get k_03avhuo => 'Create group';
	String get k_03es1ox => 'Group type';
	String get k_0wqztai => 'Group type: Work';
	String get k_0shjk7e => 'Group type: Public';
	String get k_1qrpwz6 => 'Group type: Meeting';
	String get k_0jmohdb => 'Group type: AVChatRoom';
	String get k_03f295d => 'Group notification';
	String get k_03i9mfe => 'Group introduction';
	String get k_03fchyy => 'Group profile photo';
	String get k_11msgmy => 'Select a group profile photo';
	String get k_1gyj2yl => 'Mute all members';
	String get k_0zo1d5d => 'Select group joining type';
	String get k_18epku7 => 'Create group (advanced)';
	String get k_0m7f240 => 'Remove from blocklist';
	String get k_0m3mh75 => 'Select deletion type';
	String get k_11vvszp => 'Delete group';
	String get k_1pyaxto => 'No friend request';
	String get k_0556th3 => 'Select friend request';
	String get k_121ewqv => 'Select list';
	String get k_167dvo3 => 'Select friend';
	String get k_1qdxkv0 => 'Query C2C message receiving option of user (Mute Notification status)';
	String get k_13v2x0e => 'Get friend list info';
	String get k_0rnrkt5 => 'Get online member count';
	String get k_0jd2nod => 'Select type';
	String get k_1mm5bjo => 'Get message history (advanced API; formatted data)';
	String get k_1b1tzii => 'Get native SDK version';
	String get k_0h1otop => 'Select group member';
	String get k_1ksi75r => 'Join the group first';
	String get k_11vv63p => 'Select group';
	String get k_03fglvp => 'Initialize';
	String get k_132xs0u => 'Send text';
	String get k_17argoi => 'Text content';
	String get k_1qjjcx0 => 'Only online users can receive messages';
	String get k_002ws2a => 'Invite';
	String get k_1bc6l5x => 'Greeting message when joining group';
	String get k_11vsj5s => 'Join group';
	String get k_0812nh1 => 'Remove member from group';
	String get k_1uz99pq => 'Mark C2C message as read';
	String get k_17fhxqb => 'Mark group message as read';
	String get k_13sbhj6 => 'Select message';
	String get k_1gw84h2 => 'Muted group member info';
	String get k_0mf7epf => 'Pin/Unpin conversation to/from top';
	String get k_11vsa3j => 'Leave group';
	String get k_0stba5l => 'Received';
	String get k_09ezm4w => 'Sent';
	String get k_0w3vj1s => 'Request type';
	String get k_16cx0kq => 'Friend request received by me';
	String get k_07d9n7u => 'Friend request sent by me';
	String get k_15ilfmd => 'Select type';
	String get k_0gw8cb2 => 'Reject request';
	String get k_15khfil => 'Original list name';
	String get k_15khfh6 => 'New list name';
	String get k_1cgc6p5 => 'Search keyword list, with up to 5 keywords';
	String get k_1csi4tv => 'Keyword (only 1 keyword is set in the example)';
	String get k_0q9wh26 => 'Search by userID';
	String get k_1p7cxk7 => 'Search by nickname';
	String get k_14mm3m5 => 'Search by remarks';
	String get k_03g1hin => 'Keyword';
	String get k_0xtvoya => 'Search by group member\'s userID';
	String get k_0musqvf => 'Search by group member\'s nickname';
	String get k_0v2tnyc => 'Search by group member\'s name card';
	String get k_0fgvqsh => 'Search by group member\'s remarks';
	String get k_0di7h2o => 'Search keyword (up to 5 keywords are supported; only 1 in the example)';
	String get k_139zdqj => 'Search by group ID';
	String get k_0rbflyz => 'Search by group name';
	String get k_0t9qj8k => 'Search for group';
	String get k_03rrahs => 'Keyword (required)';
	String get k_0vl6shl => 'Keyword (up to 5 keywords are supported; only 1 in the example)';
	String get k_1p5f8xt => 'Query local messages (messageList is not returned if no conversation is specified)';
	String get k_0wmcksi => 'Custom message';
	String get k_1wjd1o3 => 'Send C2C custom message (disused)';
	String get k_0qqamgs => 'Send C2C text message (disused)';
	String get k_17ix8wi => 'data';
	String get k_01cqw1f => 'desc';
	String get k_0gmtcyj => 'extension';
	String get k_03b2yxe => 'Priority';
	String get k_1wmh4z7 => 'Exclude sent messages from unread count';
	String get k_02nlunm => 'localCustomData';
	String get k_121pu0b => 'Emoji location';
	String get k_13mefja => 'Emoji info';
	String get k_1krj2k5 => 'localCustomData (file)';
	String get k_18ni1o4 => 'Select file';
	String get k_1bbh6rj => 'localCustomData (sendForwardMessage)';
	String get k_13sda1r => 'Forward message';
	String get k_08lezoy => 'Send custom message';
	String get k_05wotoe => 'Send group custom message (disused)';
	String get k_0ayxzy6 => 'Send group text message (disused)';
	String get k_0kotqjn => 'localCustomData (sendImageMessage)';
	String get k_111hdgc => 'Select image';
	String get k_060rdwo => 'Location message description';
	String get k_0lbz4k9 => 'localCustomData (sendLocationMessage)';
	String get k_1qpk5nl => 'Get current location info';
	String get k_0yn59ns => 'Conversation between XXX and XXX';
	String get k_1k1pnl2 => 'SDKs of early versions do not support text messages';
	String get k_07uflzi => 'localCustomData (sendMergerMessage)';
	String get k_13sgi0s => 'Combined message';
	String get k_09inq13 => 'localCustomData (sendSoundMessage)';
	String get k_0svi3rz => 'File deleted successfully';
	String get k_0bt4pm7 => 'Stop recording';
	String get k_0bt6ctk => 'Start recording';
	String get k_03eztxo => 'Not recorded';
	String get k_19xq0ad => 'localCustomData (sendVideoMessage)';
	String get k_0d6yawi => 'Select video';
	String get k_13qknk5 => 'Cloud data';
	String get k_0wnmtb3 => 'Modify message (string) on cloud';
	String get k_09qx4fw => 'Draft content. null means to cancel the draft.';
	String get k_1y65mf8 => 'Set draft/Cancel draft';
	String get k_1f4rg84 => 'Set conversation draft';
	String get k_02my10h => 'Group role';
	String get k_0uuoz6p => 'Select group role';
	String get k_1qe4r7d => 'Set group member role';
	String get k_0wng8yl => 'Modify local message (string)';
	String get k_1go5et7 => 'Modify local message (int)';
	String get k_15wdhxq => 'Sign-up successful';
	String get k_0yj1my7 => 'Certificate ID';
	String get k_18e393e => 'ID returned upon certificate upload in the console';
	String get k_0003v6a => 'Male';
	String get k_00043x2 => 'Female';
	String get k_0ghstt4 => 'Accept all friend requests';
	String get k_1b3mn6t => 'Reject all friend requests';
	String get k_1mo5v9d => 'Require approval for friend requests';
	String get k_003lhvk => 'Nickname';
	String get k_003q1na => 'Status';
	String get k_1hgdu7c => 'Date of birth (int)';
	String get k_003m6hr => 'Date of birth';
	String get k_003qgkp => 'Gender';
	String get k_15xu6ax => 'Select a gender';
	String get k_1pgjz7s => 'Friend request verification mode';
	String get k_0r291dl => 'Require approval for friend requests';
	String get k_003qk66 => 'Profile photo';
	String get k_161i8im => 'Select a profile photo';
	String get k_003l8z3 => 'Tip';
	String get k_142aglh => 'No app info is configured. Please configure it first.';
	String get k_03bd50d => 'Configure now';
	String get k_13m956w => 'Configuration info';
	String get k_1prb9on => 'sdkappid, applied for in the console';
	String get k_1fen6m9 => 'secret, applied for in the console';
	String get k_1xp25m6 => 'userID, any custom ID';
	String get k_12clf4v => 'Confirm configuration';
	String get k_0um8vqm => 'Clear all configuration';
	String get k_152jijg => 'Add field';
	String get k_0jbia4f => 'Configured fields:';
	String get k_0md2ud6 => 'The field name cannot be empty';
	String get k_05nspni => 'Custom field';
	String get k_03eyrxm => 'Field name';
	String get k_181l8gl => 'View it in the console';
	String get k_03fj93v => 'Field value';
	String get k_003rzap => 'OK';
	String get k_0f2heqk => '"code=0" means success. "code!=0" means failure. You can check the error code information in the Tencent Cloud IM documentation.\n';
	String get k_1r092x8 => 'Deregister groupListener';
	String k_0socms9({required Object addType}) => 'Selected: ${addType}';
	String k_14awofe({required Object friendType}) => 'Selected: ${friendType}';
	String k_0w8a6yi({required Object chooseType}) => 'Select friend on blocklist (${chooseType})';
	String k_1e74ake({required Object checkType}) => 'Selected: ${checkType}';
	String k_1pli0aq({required Object chooseType}) => 'Select conversation (${chooseType})';
	String k_0itcz3b({required Object groupType}) => 'Selected: ${groupType}';
	String k_0o7jsdm({required Object addOpt}) => 'Selected: ${addOpt}';
	String k_0is52zl({required Object deleteType}) => 'Selected: ${deleteType}';
	String k_0q8ddw7({required Object chooseType}) => 'Select friend request (${chooseType})';
	String k_1pm8o4n({required Object chooseType}) => 'Select list (${chooseType})';
	String k_1pmg14j({required Object chooseType}) => 'Select friend (${chooseType})';
	String k_0q9n4ea({required Object userStr}) => 'User to query: ${userStr}';
	String k_0v51dmo({required Object filter}) => 'Selected: ${filter}';
	String k_1laca48({required Object type}) => 'Selected: ${type}';
	String k_1pm8vid({required Object chooseType}) => 'Select group (${chooseType})';
	String k_0xpwna0({required Object senderStr}) => 'User to query: ${senderStr}';
	String k_17zxeit({required Object chooseType}) => 'Selected: ${chooseType}';
	String k_1qkm7de({required Object priority}) => 'Selected: ${priority}';
	String k_16owmwk({required Object role}) => 'Selected: ${role}';
	String k_16vvwv0({required Object chooseAllowType}) => 'Selected: ${chooseAllowType}';
	String k_0hzbevw({required Object type}) => '${type} trigger\n';
}

// Path: <root>
class _StringsZh implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZh.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsZh _root = this; // ignore: unused_field

	// Translations
	@override String get k_0fdrjph => '事件回调';
	@override String get k_15b7vxl => '基础模块';
	@override String get k_1f157p5 => '初始化SDK';
	@override String get k_06n8uqh => 'sdk 初始化';
	@override String get k_05a3xy6 => '添加事件监听';
	@override String get k_1opua40 => '事件监听应先于登录方法前添加，以防漏消息';
	@override String get k_0ptv10l => '获取服务端时间';
	@override String get k_02r2v09 => 'sdk 获取服务端时间';
	@override String get k_003r6vf => '登录';
	@override String get k_0z9427p => 'sdk 登录接口，先初始化';
	@override String get k_003ph6s => '登出';
	@override String get k_1wu4tcs => '发送C2C文本消息（3.6版本已弃用）';
	@override String get k_1t6awxa => '发送C2C自定义消息（3.6版本已弃用）';
	@override String get k_0pwzyvl => '发送Group文本消息（3.6版本已弃用）';
	@override String get k_1ntp677 => '发送Group自定义消息（3.6版本已弃用）';
	@override String get k_1j35r5o => '获取 SDK 版本';
	@override String get k_0kt7otn => '获取当前登录用户';
	@override String get k_1v7brb7 => '获取当前登录状态';
	@override String get k_0x1tylx => '获取用户信息';
	@override String get k_0elsjm2 => '创建群聊';
	@override String get k_0elrwzy => '加入群聊';
	@override String get k_0elt2dt => '退出群聊';
	@override String get k_0em2iiz => '解散群聊';
	@override String get k_0qq6zvv => '设置个人信息';
	@override String get k_11deha5 => '试验性接口';
	@override String get k_15a012s => '会话模块';
	@override String get k_1xdajb0 => '获取会话列表';
	@override String get k_1rgdedc => '获取会话详情';
	@override String get k_0glns86 => '删除会话';
	@override String get k_0xzd96m => '设置会话为草稿';
	@override String get k_0dg9tmi => '会话置顶';
	@override String get k_1vmox4p => '获取会话未读总数';
	@override String get k_15b6qz8 => '消息模块';
	@override String get k_1yns1w9 => '发送文本消息';
	@override String get k_0zq67yj => '发送自定义消息';
	@override String get k_1um4zaj => '发送图片消息';
	@override String get k_0bgy5ol => '发送视频消息';
	@override String get k_05gsxdv => '发送文件消息';
	@override String get k_0axzzec => '发送录音消息';
	@override String get k_02blxws => '发送文本At消息';
	@override String get k_1um3h9j => '发送地理位置消息';
	@override String get k_1x28z5r => '发送表情消息';
	@override String get k_0310ebw => '发送合并消息';
	@override String get k_00afgq7 => '发送转发消息';
	@override String get k_13sdbcu => '重发消息';
	@override String get k_12w209p => '修改本地消息（String）';
	@override String get k_199jsqj => '修改本地消息（Int）';
	@override String get k_0ktebqj => '修改云端消息（String-已弃用）';
	@override String get k_0k6jqud => '获取C2C历史消息';
	@override String get k_0bf7otk => '获取Group历史消息';
	@override String get k_1fbo5v2 => '获取历史消息高级接口';
	@override String get k_1asy1yf => '获取历史消息高级接口（不格式化）';
	@override String get k_13sdxko => '撤回消息';
	@override String get k_1vlsgoe => '标记C2C会话已读';
	@override String get k_17fh8gz => '标记Group会话已读';
	@override String get k_16sb1e7 => '标记所有消息为已读';
	@override String get k_01q04pm => '删除本地消息';
	@override String get k_13sqfye => '删除消息';
	@override String get k_1saxzrf => '向group中插入一条本地消息';
	@override String get k_075u68x => '向c2c会话中插入一条本地消息';
	@override String get k_16tukku => '清空单聊本地及云端的消息';
	@override String get k_13z9nvj => '获取用户消息接收选项';
	@override String get k_182b8ni => '清空群组单聊本地及云端的消息';
	@override String get k_01qv9eo => '搜索本地消息';
	@override String get k_0bfyrre => '查询指定会话中的本地消息';
	@override String get k_0mz8nlf => '好友关系链模块';
	@override String get k_10ig2ml => '获取好友列表';
	@override String get k_0q5feak => '获取好友信息';
	@override String get k_16758qw => '添加好友';
	@override String get k_0q5kkj1 => '设置好友信息';
	@override String get k_1666obb => '删除好友';
	@override String get k_167fad4 => '检测好友';
	@override String get k_15gn1d5 => '获取好友申请列表';
	@override String get k_05576s4 => '同意好友申请';
	@override String get k_055cno8 => '拒绝好友申请';
	@override String get k_0m517oy => '获取黑名单列表';
	@override String get k_042sv53 => '添加到黑名单';
	@override String get k_1oybli5 => '从黑名单移除';
	@override String get k_05jmpkg => '创建好友分组';
	@override String get k_05jnyuo => '获取好友分组';
	@override String get k_05jcbyt => '删除好友分组';
	@override String get k_14xxze4 => '重命名好友分组';
	@override String get k_14kqmvu => '添加好友到分组';
	@override String get k_00mp87q => '从分组中删除好友';
	@override String get k_167cp0t => '搜索好友';
	@override String get k_15b6vqr => '群组模块';
	@override String get k_1j2fn17 => '高级创建群组';
	@override String get k_16mti73 => '获取加群列表';
	@override String get k_0suniq6 => '获取群信息';
	@override String get k_0supwn3 => '设置群信息';
	@override String get k_1ojrrgd => '获取群在线人数';
	@override String get k_1pb3f1z => '获取群成员列表';
	@override String get k_1gx3i86 => '获取群成员信息';
	@override String get k_1gwzvg7 => '设置群成员信息';
	@override String get k_0h1ttfs => '禁言群成员';
	@override String get k_0c9tkhn => '邀请好友进群';
	@override String get k_11yzdz7 => '踢人出群';
	@override String get k_0uupir5 => '设置群角色';
	@override String get k_18pxx1p => '转移群主';
	@override String get k_0r4h8ww => '搜索群列表';
	@override String get k_0h1m7ef => '搜索群成员';
	@override String get k_15az05y => '信令模块';
	@override String get k_0gzsnbo => '发起邀请';
	@override String get k_1ifjitt => '在群组中发起邀请';
	@override String get k_0qr6nnz => '获取信令信息';
	@override String get k_0hsgjrg => '添加邀请信令';
	@override String get k_1499er2 => '添加邀请信令（可以用于群离线推送消息触发的邀请信令）';
	@override String get k_1rmuiim => '离线推送模块';
	@override String get k_1uobs68 => '上报推送配置';
	@override String get k_18ufun0 => '注册事件';
	@override String get k_0dyrkl5 => '注销simpleMsgListener事件';
	@override String get k_1q2xs9c => '注销所有simpleMsgListener事件';
	@override String get k_0fyg1xs => '注销advanceMsgListener';
	@override String get k_0awkp15 => '注销所有advanceMsgListener';
	@override String get k_12oryz1 => '注销signalingListener';
	@override String get k_1xb912c => '注销所有signalingListener';
	@override String get k_1r092x8 => '注销gruopListener';
	@override String get k_1ec07ke => '被添加好友ID';
	@override String get k_14bwl8c => '好友备注';
	@override String get k_121555d => '好友分组';
	@override String get k_0qbtor0 => '好友分组，首先得有这个分组';
	@override String get k_0gavw6m => '添加简述';
	@override String get k_15ihgoz => '好友类型';
	@override String get k_1675qge => '双向好友';
	@override String get k_1675qk7 => '单向好友';
	@override String get k_1eopfpu => '选择优先级';
	@override String k_0socms9({required Object addType}) => '已选：${addType}';
	@override String get k_03c51e7 => '未选择';
	@override String get k_0ethd0p => '添加信令信息（选择已有的信令信息进行测试）';
	@override String get k_15i526p => '删除类型';
	@override String get k_1ciwziu => '同意添加双向好友';
	@override String get k_19iuz0v => '同意添加单向好友';
	@override String get k_0ix65gm => '选择同意类型类型';
	@override String k_14awofe({required Object friendType}) => '已选：${friendType}';
	@override String get k_0gw88si => '同意申请';
	@override String get k_0xxojzb => '收到的事件回调';
	@override String get k_0quw2i5 => '单选只能选一个呀';
	@override String get k_002r2pl => '单选';
	@override String get k_002r1h2 => '多选';
	@override String k_0w8a6yi({required Object chooseType}) => '黑名单好友选择（${chooseType}）';
	@override String get k_002v9zj => '确认';
	@override String get k_003nevv => '取消';
	@override String get k_03mgr50 => '请先在好友关系链模块中添加好友';
	@override String get k_1ic4dp6 => '选择黑名单好友';
	@override String get k_161zzkm => '请输入用户名';
	@override String get k_00alow4 => '调用实验性接口：初始化本地数据库（您可以在SDK中自行尝试其他接口）';
	@override String get k_1xogzdp => '调用实验性接口';
	@override String get k_15ijita => '检测类型';
	@override String get k_0y8ersu => '选择检测类型';
	@override String k_1e74ake({required Object checkType}) => '已选：${checkType}';
	@override String get k_0iilkht => '清空单聊本地及云端的消息（不删除会话）';
	@override String get k_0szs46i => '获取群组信息';
	@override String k_1pli0aq({required Object chooseType}) => '会话选择（${chooseType}）';
	@override String get k_0hqslym => '暂无会话信息';
	@override String get k_0gmqf8i => '选择会话';
	@override String get k_03eu3my => '分组名';
	@override String get k_03768rw => '群ID';
	@override String get k_1vjwjey => '选填（如填，则自定义群ID）';
	@override String get k_03agq58 => '群名称';
	@override String get k_0kg1wsx => '选择群类型';
	@override String get k_0lzvumx => 'Work 工作群';
	@override String get k_0mbokjw => 'Public 公开群';
	@override String get k_028lr1o => 'Meeting 会议群';
	@override String get k_1te7y0e => 'AVChatRoom 直播群';
	@override String k_0itcz3b({required Object groupType}) => '已选：${groupType}';
	@override String get k_03avhuo => '创建群';
	@override String get k_03es1ox => '群类型';
	@override String get k_0wqztai => '群类型：Work';
	@override String get k_0shjk7e => '群类型：Public';
	@override String get k_1qrpwz6 => '群类型：Meeting';
	@override String get k_0jmohdb => '群类型r：AVChatRoom';
	@override String get k_03f295d => '群通告';
	@override String get k_03i9mfe => '群简介';
	@override String get k_03fchyy => '群头像';
	@override String get k_11msgmy => '选择群头像';
	@override String get k_1gyj2yl => '是否全员禁言';
	@override String get k_0zo1d5d => '选择加群类型';
	@override String k_0o7jsdm({required Object addOpt}) => '已选：${addOpt}';
	@override String get k_18epku7 => '高级创建群';
	@override String get k_0m7f240 => '从黑名单中移除';
	@override String get k_0m3mh75 => '选择删除类型';
	@override String k_0is52zl({required Object deleteType}) => '已选：${deleteType}';
	@override String get k_11vvszp => '解散群组';
	@override String k_0q8ddw7({required Object chooseType}) => '好友申请选择（${chooseType}）';
	@override String get k_1pyaxto => '目前没有好友申请';
	@override String get k_0556th3 => '选择好友申请';
	@override String k_1pm8o4n({required Object chooseType}) => '分组选择（${chooseType}）';
	@override String get k_121ewqv => '选择分组';
	@override String k_1pmg14j({required Object chooseType}) => '好友选择（${chooseType}）';
	@override String get k_167dvo3 => '选择好友';
	@override String k_0q9n4ea({required Object userStr}) => '要查询的用户: ${userStr}';
	@override String get k_1qdxkv0 => '查询针对某个用户的 C2C 消息接收选项（免打扰状态）';
	@override String get k_13v2x0e => '获取好友分组信息';
	@override String k_0v51dmo({required Object filter}) => '已选：${filter}';
	@override String get k_0rnrkt5 => '获取在线人数';
	@override String get k_0jd2nod => '选择type';
	@override String k_1laca48({required Object type}) => '已选：${type}';
	@override String get k_1mm5bjo => '获取历史消息高级接口（格式化数据）';
	@override String get k_1b1tzii => '获取native sdk版本号';
	@override String get k_0h1otop => '选择群成员';
	@override String k_1pm8vid({required Object chooseType}) => '群组选择（${chooseType}）';
	@override String get k_1ksi75r => '请先加入群组';
	@override String get k_11vv63p => '选择群组';
	@override String get k_03fglvp => '初始化';
	@override String k_0xpwna0({required Object senderStr}) => '要查询的用户: ${senderStr}';
	@override String get k_132xs0u => '发送文本';
	@override String get k_17argoi => '文本内容';
	@override String get k_1qjjcx0 => '是否仅在线用户接受到消息';
	@override String get k_002ws2a => '邀请';
	@override String get k_1bc6l5x => '进群打招呼Message';
	@override String get k_11vsj5s => '加入群组';
	@override String get k_0812nh1 => '踢群成员出群';
	@override String get k_1uz99pq => '标记c2c会话已读';
	@override String get k_17fhxqb => '标记group会话已读';
	@override String get k_13sbhj6 => '选择消息';
	@override String get k_1gw84h2 => '禁言群成员信息';
	@override String get k_0mf7epf => '会话置顶/取消置顶';
	@override String get k_11vsa3j => '退出群组';
	@override String get k_0stba5l => '别人发给我的';
	@override String get k_09ezm4w => '我发别人的';
	@override String get k_0w3vj1s => '请求类型类型';
	@override String get k_16cx0kq => '别人发给我的加好友请求';
	@override String get k_07d9n7u => '我发给别人的加好友请求';
	@override String get k_15ilfmd => '选择类型';
	@override String k_17zxeit({required Object chooseType}) => '已选：${chooseType}';
	@override String get k_0gw8cb2 => '拒绝申请';
	@override String get k_15khfil => '旧分组名';
	@override String get k_15khfh6 => '新分组名';
	@override String get k_1cgc6p5 => '搜索关键字列表，最多支持5个';
	@override String get k_1csi4tv => '关键字(example只有设置了一个关键字)';
	@override String get k_0q9wh26 => '设置是否搜索userID';
	@override String get k_1p7cxk7 => '是否设置搜索昵称';
	@override String get k_14mm3m5 => '设置是否搜索备注';
	@override String get k_03g1hin => '关键字';
	@override String get k_0xtvoya => '设置是否搜索群成员 userID';
	@override String get k_0musqvf => '设置是否搜索群成员昵称';
	@override String get k_0v2tnyc => '设置是否搜索群成员名片';
	@override String get k_0fgvqsh => '设置是否搜索群成员备注';
	@override String get k_0di7h2o => '搜索关键字(最多支持五个，example只支持一个)';
	@override String get k_139zdqj => '设置是否搜索群 ID';
	@override String get k_0rbflyz => '设置是否搜索群名称';
	@override String get k_0t9qj8k => '搜索Group';
	@override String get k_03rrahs => '关键字(必填)';
	@override String get k_0vl6shl => '关键字（接口支持5个，example支持一个）';
	@override String get k_1p5f8xt => '查询本地消息(不指定会话不返回messageList)';
	@override String get k_0wmcksi => '自定义数据';
	@override String get k_1wjd1o3 => '发送C2C自定义消息（弃用）';
	@override String get k_0qqamgs => '发送C2C文本消息（已经弃用）';
	@override String get k_17ix8wi => '自定义数据data';
	@override String get k_01cqw1f => '自定义数据desc';
	@override String get k_0gmtcyj => '自定义数据extension';
	@override String get k_03b2yxe => '优先级';
	@override String k_1qkm7de({required Object priority}) => '已选：${priority}';
	@override String get k_1wmh4z7 => '发送消息是否不计入未读数';
	@override String get k_02nlunm => '自定义localCustomData';
	@override String get k_121pu0b => '表情位置';
	@override String get k_13mefja => '表情信息';
	@override String get k_1krj2k5 => '自定义localCustomData(File)';
	@override String get k_18ni1o4 => '选择文件';
	@override String get k_1bbh6rj => '自定义localCustomData(sendForwardMessage)';
	@override String get k_13sda1r => '转发消息';
	@override String get k_08lezoy => '发送自定义数据';
	@override String get k_05wotoe => '发送Group自定义消息(弃用)';
	@override String get k_0ayxzy6 => '发送Group文本消息（已弃用）';
	@override String get k_0kotqjn => '自定义localCustomData(sendImageMessage)';
	@override String get k_111hdgc => '选择图片';
	@override String get k_060rdwo => '地理位置消息描述';
	@override String get k_0lbz4k9 => '自定义localCustomData(sendLocationMessage)';
	@override String get k_1qpk5nl => '获取当前地理位置信息';
	@override String get k_0yn59ns => 'XXX与XXX的会话';
	@override String get k_1k1pnl2 => '低版本不支持会会收到文本消息';
	@override String get k_07uflzi => '自定义localCustomData(sendMergerMessage)';
	@override String get k_13sgi0s => '合并消息';
	@override String get k_09inq13 => '自定义localCustomData(sendSoundMessage)';
	@override String get k_0svi3rz => '删除文件成功';
	@override String get k_0bt4pm7 => '结束录音';
	@override String get k_0bt6ctk => '开始录音';
	@override String get k_03eztxo => '未录制';
	@override String get k_19xq0ad => '自定义localCustomData(sendVideoMessage)';
	@override String get k_0d6yawi => '选择视频';
	@override String get k_13qknk5 => '云端数据';
	@override String get k_0wnmtb3 => '云端修改消息（String）';
	@override String get k_09qx4fw => '草稿内容，null为取消';
	@override String get k_1y65mf8 => '设置草稿/取消草稿';
	@override String get k_1f4rg84 => '设置会话草稿';
	@override String get k_02my10h => '群角色';
	@override String get k_0uuoz6p => '选择群角色';
	@override String k_16owmwk({required Object role}) => '已选：${role}';
	@override String get k_1qe4r7d => '设置群成员角色';
	@override String get k_0wng8yl => '本地修改消息（String）';
	@override String get k_1go5et7 => '本地修改消息（Int）';
	@override String get k_15wdhxq => '注册成功';
	@override String get k_0yj1my7 => '证书id';
	@override String get k_18e393e => '控制台上传证书返回的id';
	@override String get k_0003v6a => '男';
	@override String get k_00043x2 => '女';
	@override String get k_0ghstt4 => '允许所有人加我好友';
	@override String get k_1b3mn6t => '不允许所有人加我好友';
	@override String get k_1mo5v9d => '加我好友许我确认';
	@override String get k_003lhvk => '昵称';
	@override String get k_003q1na => '签名';
	@override String get k_1hgdu7c => '生日(int类型，不要输入字符串)';
	@override String get k_003m6hr => '生日';
	@override String get k_003qgkp => '性别';
	@override String get k_15xu6ax => '选择性别';
	@override String get k_1pgjz7s => '加好友验证方式';
	@override String get k_0r291dl => '加我好友需我确认';
	@override String k_16vvwv0({required Object chooseAllowType}) => '已选：${chooseAllowType}';
	@override String get k_003qk66 => '头像';
	@override String get k_161i8im => '选择头像';
	@override String get k_003l8z3 => '提示';
	@override String get k_142aglh => '检测到您还未配置应用信息，请先配置';
	@override String get k_03bd50d => '去配置';
	@override String get k_13m956w => '配置信息';
	@override String get k_1prb9on => 'sdkappid，控制台去申请';
	@override String get k_1fen6m9 => 'secret，控制台去申请';
	@override String get k_1xp25m6 => 'userID，随便填';
	@override String get k_12clf4v => '确认设置';
	@override String get k_0um8vqm => '清除所有配置';
	@override String get k_152jijg => '添加字段';
	@override String get k_0jbia4f => '已设置字段：';
	@override String get k_0md2ud6 => '字段名不能为空';
	@override String get k_05nspni => '自定义字段';
	@override String get k_03eyrxm => '字段名';
	@override String get k_181l8gl => '请在控制台查看';
	@override String get k_03fj93v => '字段值';
	@override String get k_003rzap => '确定';
	@override String get k_0f2heqk => 'code=0 业务成功 code!=0 业务失败，请在腾讯云即时通信文档文档查看对应的错误码信息。\n';
	@override String k_0hzbevw({required Object type}) => '${type}触发\n';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'k_0fdrjph': return 'Event callback';
			case 'k_15b7vxl': return 'Basic module';
			case 'k_1f157p5': return 'Initialize SDK';
			case 'k_06n8uqh': return 'Initialize SDK';
			case 'k_05a3xy6': return 'Add event listener';
			case 'k_1opua40': return 'Add an event listener before adding a login method to avoid missing messages';
			case 'k_0ptv10l': return 'Get server time';
			case 'k_02r2v09': return 'Get server time by SDK';
			case 'k_003r6vf': return 'Log in';
			case 'k_0z9427p': return 'SDK login API. Initialize the SDK first.';
			case 'k_003ph6s': return 'Log out';
			case 'k_1wu4tcs': return 'Send C2C text message (disused since v3.6)';
			case 'k_1t6awxa': return 'Send C2C custom message (disused since v3.6)';
			case 'k_0pwzyvl': return 'Send group text message (disused since v3.6)';
			case 'k_1ntp677': return 'Send group custom message (disused since v3.6)';
			case 'k_1j35r5o': return 'Get SDK version';
			case 'k_0kt7otn': return 'Get current login user';
			case 'k_1v7brb7': return 'Get current login status';
			case 'k_0x1tylx': return 'Get user info';
			case 'k_0elsjm2': return 'Create group chat';
			case 'k_0elrwzy': return 'Join group chat';
			case 'k_0elt2dt': return 'Quit group chat';
			case 'k_0em2iiz': return 'Delete group chat';
			case 'k_0qq6zvv': return 'Set personal profile';
			case 'k_11deha5': return 'Experimental API';
			case 'k_15a012s': return 'Conversation module';
			case 'k_1xdajb0': return 'Get conversation list';
			case 'k_1rgdedc': return 'Get conversation details';
			case 'k_0glns86': return 'Delete conversation';
			case 'k_0xzd96m': return 'Set conversation as draft';
			case 'k_0dg9tmi': return 'Pin conversation to top';
			case 'k_1vmox4p': return 'Get conversation\'s total message unread count';
			case 'k_15b6qz8': return 'Message module';
			case 'k_1yns1w9': return 'Send text message';
			case 'k_0zq67yj': return 'Send custom message';
			case 'k_1um4zaj': return 'Send image message';
			case 'k_0bgy5ol': return 'Send video message';
			case 'k_05gsxdv': return 'Send file message';
			case 'k_0axzzec': return 'Send voice message';
			case 'k_02blxws': return 'Send text @ message';
			case 'k_1um3h9j': return 'Send geographical location message';
			case 'k_1x28z5r': return 'Send emoji message';
			case 'k_0310ebw': return 'Send combined message';
			case 'k_00afgq7': return 'Send forward message';
			case 'k_13sdbcu': return 'Resend message';
			case 'k_12w209p': return 'Modify local message (string)';
			case 'k_199jsqj': return 'Modify local message (int)';
			case 'k_0ktebqj': return 'Modify cloud message (string; disused)';
			case 'k_0k6jqud': return 'Get C2C message history';
			case 'k_0bf7otk': return 'Get group message history';
			case 'k_1fbo5v2': return 'Get message history (advanced API)';
			case 'k_1asy1yf': return 'Get message history (advanced API; unformatted)';
			case 'k_13sdxko': return 'Recall message';
			case 'k_1vlsgoe': return 'Mark C2C message as read';
			case 'k_17fh8gz': return 'Mark group message as read';
			case 'k_16sb1e7': return 'Mark all messages as read';
			case 'k_01q04pm': return 'Delete local message';
			case 'k_13sqfye': return 'Delete message';
			case 'k_1saxzrf': return 'Insert local message to group chat';
			case 'k_075u68x': return 'Insert local message to C2C chat';
			case 'k_16tukku': return 'Clear local and cloud C2C message history';
			case 'k_13z9nvj': return 'Get user message receiving option';
			case 'k_182b8ni': return 'Clear local and cloud group message history';
			case 'k_01qv9eo': return 'Search for local messages';
			case 'k_0bfyrre': return 'Query local messages in a specified conversation';
			case 'k_0mz8nlf': return 'Friend relationship chain module';
			case 'k_10ig2ml': return 'Get friend list';
			case 'k_0q5feak': return 'Get friend info';
			case 'k_16758qw': return 'Add friend';
			case 'k_0q5kkj1': return 'Set friend info';
			case 'k_1666obb': return 'Delete friend';
			case 'k_167fad4': return 'Check friend';
			case 'k_15gn1d5': return 'Get friend request list';
			case 'k_05576s4': return 'Accept friend request';
			case 'k_055cno8': return 'Reject friend request';
			case 'k_0m517oy': return 'Get blocklist';
			case 'k_042sv53': return 'Add to blocklist';
			case 'k_1oybli5': return 'Remove from blocklist';
			case 'k_05jmpkg': return 'Create friend list';
			case 'k_05jnyuo': return 'Get friend list';
			case 'k_05jcbyt': return 'Delete friend list';
			case 'k_14xxze4': return 'Rename friend list';
			case 'k_14kqmvu': return 'Add friend to friend list';
			case 'k_00mp87q': return 'Remove friend from friend list';
			case 'k_167cp0t': return 'Search for friend';
			case 'k_15b6vqr': return 'Group module';
			case 'k_1j2fn17': return 'Create group (advanced)';
			case 'k_16mti73': return 'Get group joining request list';
			case 'k_0suniq6': return 'Get group info';
			case 'k_0supwn3': return 'Set group info';
			case 'k_1ojrrgd': return 'Get online group member count';
			case 'k_1pb3f1z': return 'Get group member list';
			case 'k_1gx3i86': return 'Get group member info';
			case 'k_1gwzvg7': return 'Set group member info';
			case 'k_0h1ttfs': return 'Mute group member';
			case 'k_0c9tkhn': return 'Invite friend to group';
			case 'k_11yzdz7': return 'Remove member from group';
			case 'k_0uupir5': return 'Set group role';
			case 'k_18pxx1p': return 'Transfer group owner';
			case 'k_0r4h8ww': return 'Search for group list';
			case 'k_0h1m7ef': return 'Search for group member';
			case 'k_15az05y': return 'Signaling module';
			case 'k_0gzsnbo': return 'Send invitation';
			case 'k_1ifjitt': return 'Send invitation in group';
			case 'k_0qr6nnz': return 'Get signaling info';
			case 'k_0hsgjrg': return 'Add invitation signaling';
			case 'k_1499er2': return 'Add invitation signaling (triggered by group offline push messages)';
			case 'k_1rmuiim': return 'Offline push module';
			case 'k_1uobs68': return 'Report push configuration';
			case 'k_18ufun0': return 'Register event';
			case 'k_0dyrkl5': return 'Deregister simpleMsgListener event';
			case 'k_1q2xs9c': return 'Deregister all simpleMsgListener events';
			case 'k_0fyg1xs': return 'Deregister advanceMsgListener event';
			case 'k_0awkp15': return 'Deregister all advanceMsgListener events';
			case 'k_12oryz1': return 'Deregister signalingListener event';
			case 'k_1xb912c': return 'Deregister all signalingListener events';
			case 'k_1ec07ke': return 'Friend ID';
			case 'k_14bwl8c': return 'Friend remarks';
			case 'k_121555d': return 'Friend list';
			case 'k_0qbtor0': return 'Friend list, which must exist';
			case 'k_0gavw6m': return 'Add remarks';
			case 'k_15ihgoz': return 'Friend type';
			case 'k_1675qge': return 'Two-way friend';
			case 'k_1675qk7': return 'One-way friend';
			case 'k_1eopfpu': return 'Select priority';
			case 'k_03c51e7': return 'Not selected';
			case 'k_0ethd0p': return 'Add signaling info (select existing signaling info to test)';
			case 'k_15i526p': return 'Delete type';
			case 'k_1ciwziu': return 'Agree to add as two-way friend';
			case 'k_19iuz0v': return 'Agree to add as one-way friend';
			case 'k_0ix65gm': return 'Select friend type to agree';
			case 'k_0gw88si': return 'Accept request';
			case 'k_0xxojzb': return 'Received event callback';
			case 'k_0quw2i5': return 'Select only one option';
			case 'k_002r2pl': return 'Single-choice';
			case 'k_002r1h2': return 'Multiple-choice';
			case 'k_002v9zj': return 'OK';
			case 'k_003nevv': return 'Cancel';
			case 'k_03mgr50': return 'Add the friend in the friend relationship chain module first';
			case 'k_1ic4dp6': return 'Select friend on blocklist';
			case 'k_161zzkm': return 'Enter username';
			case 'k_00alow4': return 'Call the experimental API for initializing local database (you can also call another API in the SDK)';
			case 'k_1xogzdp': return 'Call experimental API';
			case 'k_15ijita': return 'Check type';
			case 'k_0y8ersu': return 'Select check type';
			case 'k_0iilkht': return 'Clear local and cloud C2C message history (without deleting the conversation)';
			case 'k_0szs46i': return 'Get group information';
			case 'k_0hqslym': return 'No conversation information available';
			case 'k_0gmqf8i': return 'Select conversation';
			case 'k_03eu3my': return 'List name';
			case 'k_03768rw': return 'Group ID';
			case 'k_1vjwjey': return '(Optional) Enter a custom group ID';
			case 'k_03agq58': return 'Group name';
			case 'k_0kg1wsx': return 'Select a group type';
			case 'k_0lzvumx': return 'Work';
			case 'k_0mbokjw': return 'Public';
			case 'k_028lr1o': return 'Meeting';
			case 'k_1te7y0e': return 'AVChatRoom';
			case 'k_03avhuo': return 'Create group';
			case 'k_03es1ox': return 'Group type';
			case 'k_0wqztai': return 'Group type: Work';
			case 'k_0shjk7e': return 'Group type: Public';
			case 'k_1qrpwz6': return 'Group type: Meeting';
			case 'k_0jmohdb': return 'Group type: AVChatRoom';
			case 'k_03f295d': return 'Group notification';
			case 'k_03i9mfe': return 'Group introduction';
			case 'k_03fchyy': return 'Group profile photo';
			case 'k_11msgmy': return 'Select a group profile photo';
			case 'k_1gyj2yl': return 'Mute all members';
			case 'k_0zo1d5d': return 'Select group joining type';
			case 'k_18epku7': return 'Create group (advanced)';
			case 'k_0m7f240': return 'Remove from blocklist';
			case 'k_0m3mh75': return 'Select deletion type';
			case 'k_11vvszp': return 'Delete group';
			case 'k_1pyaxto': return 'No friend request';
			case 'k_0556th3': return 'Select friend request';
			case 'k_121ewqv': return 'Select list';
			case 'k_167dvo3': return 'Select friend';
			case 'k_1qdxkv0': return 'Query C2C message receiving option of user (Mute Notification status)';
			case 'k_13v2x0e': return 'Get friend list info';
			case 'k_0rnrkt5': return 'Get online member count';
			case 'k_0jd2nod': return 'Select type';
			case 'k_1mm5bjo': return 'Get message history (advanced API; formatted data)';
			case 'k_1b1tzii': return 'Get native SDK version';
			case 'k_0h1otop': return 'Select group member';
			case 'k_1ksi75r': return 'Join the group first';
			case 'k_11vv63p': return 'Select group';
			case 'k_03fglvp': return 'Initialize';
			case 'k_132xs0u': return 'Send text';
			case 'k_17argoi': return 'Text content';
			case 'k_1qjjcx0': return 'Only online users can receive messages';
			case 'k_002ws2a': return 'Invite';
			case 'k_1bc6l5x': return 'Greeting message when joining group';
			case 'k_11vsj5s': return 'Join group';
			case 'k_0812nh1': return 'Remove member from group';
			case 'k_1uz99pq': return 'Mark C2C message as read';
			case 'k_17fhxqb': return 'Mark group message as read';
			case 'k_13sbhj6': return 'Select message';
			case 'k_1gw84h2': return 'Muted group member info';
			case 'k_0mf7epf': return 'Pin/Unpin conversation to/from top';
			case 'k_11vsa3j': return 'Leave group';
			case 'k_0stba5l': return 'Received';
			case 'k_09ezm4w': return 'Sent';
			case 'k_0w3vj1s': return 'Request type';
			case 'k_16cx0kq': return 'Friend request received by me';
			case 'k_07d9n7u': return 'Friend request sent by me';
			case 'k_15ilfmd': return 'Select type';
			case 'k_0gw8cb2': return 'Reject request';
			case 'k_15khfil': return 'Original list name';
			case 'k_15khfh6': return 'New list name';
			case 'k_1cgc6p5': return 'Search keyword list, with up to 5 keywords';
			case 'k_1csi4tv': return 'Keyword (only 1 keyword is set in the example)';
			case 'k_0q9wh26': return 'Search by userID';
			case 'k_1p7cxk7': return 'Search by nickname';
			case 'k_14mm3m5': return 'Search by remarks';
			case 'k_03g1hin': return 'Keyword';
			case 'k_0xtvoya': return 'Search by group member\'s userID';
			case 'k_0musqvf': return 'Search by group member\'s nickname';
			case 'k_0v2tnyc': return 'Search by group member\'s name card';
			case 'k_0fgvqsh': return 'Search by group member\'s remarks';
			case 'k_0di7h2o': return 'Search keyword (up to 5 keywords are supported; only 1 in the example)';
			case 'k_139zdqj': return 'Search by group ID';
			case 'k_0rbflyz': return 'Search by group name';
			case 'k_0t9qj8k': return 'Search for group';
			case 'k_03rrahs': return 'Keyword (required)';
			case 'k_0vl6shl': return 'Keyword (up to 5 keywords are supported; only 1 in the example)';
			case 'k_1p5f8xt': return 'Query local messages (messageList is not returned if no conversation is specified)';
			case 'k_0wmcksi': return 'Custom message';
			case 'k_1wjd1o3': return 'Send C2C custom message (disused)';
			case 'k_0qqamgs': return 'Send C2C text message (disused)';
			case 'k_17ix8wi': return 'data';
			case 'k_01cqw1f': return 'desc';
			case 'k_0gmtcyj': return 'extension';
			case 'k_03b2yxe': return 'Priority';
			case 'k_1wmh4z7': return 'Exclude sent messages from unread count';
			case 'k_02nlunm': return 'localCustomData';
			case 'k_121pu0b': return 'Emoji location';
			case 'k_13mefja': return 'Emoji info';
			case 'k_1krj2k5': return 'localCustomData (file)';
			case 'k_18ni1o4': return 'Select file';
			case 'k_1bbh6rj': return 'localCustomData (sendForwardMessage)';
			case 'k_13sda1r': return 'Forward message';
			case 'k_08lezoy': return 'Send custom message';
			case 'k_05wotoe': return 'Send group custom message (disused)';
			case 'k_0ayxzy6': return 'Send group text message (disused)';
			case 'k_0kotqjn': return 'localCustomData (sendImageMessage)';
			case 'k_111hdgc': return 'Select image';
			case 'k_060rdwo': return 'Location message description';
			case 'k_0lbz4k9': return 'localCustomData (sendLocationMessage)';
			case 'k_1qpk5nl': return 'Get current location info';
			case 'k_0yn59ns': return 'Conversation between XXX and XXX';
			case 'k_1k1pnl2': return 'SDKs of early versions do not support text messages';
			case 'k_07uflzi': return 'localCustomData (sendMergerMessage)';
			case 'k_13sgi0s': return 'Combined message';
			case 'k_09inq13': return 'localCustomData (sendSoundMessage)';
			case 'k_0svi3rz': return 'File deleted successfully';
			case 'k_0bt4pm7': return 'Stop recording';
			case 'k_0bt6ctk': return 'Start recording';
			case 'k_03eztxo': return 'Not recorded';
			case 'k_19xq0ad': return 'localCustomData (sendVideoMessage)';
			case 'k_0d6yawi': return 'Select video';
			case 'k_13qknk5': return 'Cloud data';
			case 'k_0wnmtb3': return 'Modify message (string) on cloud';
			case 'k_09qx4fw': return 'Draft content. null means to cancel the draft.';
			case 'k_1y65mf8': return 'Set draft/Cancel draft';
			case 'k_1f4rg84': return 'Set conversation draft';
			case 'k_02my10h': return 'Group role';
			case 'k_0uuoz6p': return 'Select group role';
			case 'k_1qe4r7d': return 'Set group member role';
			case 'k_0wng8yl': return 'Modify local message (string)';
			case 'k_1go5et7': return 'Modify local message (int)';
			case 'k_15wdhxq': return 'Sign-up successful';
			case 'k_0yj1my7': return 'Certificate ID';
			case 'k_18e393e': return 'ID returned upon certificate upload in the console';
			case 'k_0003v6a': return 'Male';
			case 'k_00043x2': return 'Female';
			case 'k_0ghstt4': return 'Accept all friend requests';
			case 'k_1b3mn6t': return 'Reject all friend requests';
			case 'k_1mo5v9d': return 'Require approval for friend requests';
			case 'k_003lhvk': return 'Nickname';
			case 'k_003q1na': return 'Status';
			case 'k_1hgdu7c': return 'Date of birth (int)';
			case 'k_003m6hr': return 'Date of birth';
			case 'k_003qgkp': return 'Gender';
			case 'k_15xu6ax': return 'Select a gender';
			case 'k_1pgjz7s': return 'Friend request verification mode';
			case 'k_0r291dl': return 'Require approval for friend requests';
			case 'k_003qk66': return 'Profile photo';
			case 'k_161i8im': return 'Select a profile photo';
			case 'k_003l8z3': return 'Tip';
			case 'k_142aglh': return 'No app info is configured. Please configure it first.';
			case 'k_03bd50d': return 'Configure now';
			case 'k_13m956w': return 'Configuration info';
			case 'k_1prb9on': return 'sdkappid, applied for in the console';
			case 'k_1fen6m9': return 'secret, applied for in the console';
			case 'k_1xp25m6': return 'userID, any custom ID';
			case 'k_12clf4v': return 'Confirm configuration';
			case 'k_0um8vqm': return 'Clear all configuration';
			case 'k_152jijg': return 'Add field';
			case 'k_0jbia4f': return 'Configured fields:';
			case 'k_0md2ud6': return 'The field name cannot be empty';
			case 'k_05nspni': return 'Custom field';
			case 'k_03eyrxm': return 'Field name';
			case 'k_181l8gl': return 'View it in the console';
			case 'k_03fj93v': return 'Field value';
			case 'k_003rzap': return 'OK';
			case 'k_0f2heqk': return '"code=0" means success. "code!=0" means failure. You can check the error code information in the Tencent Cloud IM documentation.\n';
			case 'k_1r092x8': return 'Deregister groupListener';
			case 'k_0socms9': return ({required Object addType}) => 'Selected: ${addType}';
			case 'k_14awofe': return ({required Object friendType}) => 'Selected: ${friendType}';
			case 'k_0w8a6yi': return ({required Object chooseType}) => 'Select friend on blocklist (${chooseType})';
			case 'k_1e74ake': return ({required Object checkType}) => 'Selected: ${checkType}';
			case 'k_1pli0aq': return ({required Object chooseType}) => 'Select conversation (${chooseType})';
			case 'k_0itcz3b': return ({required Object groupType}) => 'Selected: ${groupType}';
			case 'k_0o7jsdm': return ({required Object addOpt}) => 'Selected: ${addOpt}';
			case 'k_0is52zl': return ({required Object deleteType}) => 'Selected: ${deleteType}';
			case 'k_0q8ddw7': return ({required Object chooseType}) => 'Select friend request (${chooseType})';
			case 'k_1pm8o4n': return ({required Object chooseType}) => 'Select list (${chooseType})';
			case 'k_1pmg14j': return ({required Object chooseType}) => 'Select friend (${chooseType})';
			case 'k_0q9n4ea': return ({required Object userStr}) => 'User to query: ${userStr}';
			case 'k_0v51dmo': return ({required Object filter}) => 'Selected: ${filter}';
			case 'k_1laca48': return ({required Object type}) => 'Selected: ${type}';
			case 'k_1pm8vid': return ({required Object chooseType}) => 'Select group (${chooseType})';
			case 'k_0xpwna0': return ({required Object senderStr}) => 'User to query: ${senderStr}';
			case 'k_17zxeit': return ({required Object chooseType}) => 'Selected: ${chooseType}';
			case 'k_1qkm7de': return ({required Object priority}) => 'Selected: ${priority}';
			case 'k_16owmwk': return ({required Object role}) => 'Selected: ${role}';
			case 'k_16vvwv0': return ({required Object chooseAllowType}) => 'Selected: ${chooseAllowType}';
			case 'k_0hzbevw': return ({required Object type}) => '${type} trigger\n';
			default: return null;
		}
	}
}

extension on _StringsZh {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'k_0fdrjph': return '事件回调';
			case 'k_15b7vxl': return '基础模块';
			case 'k_1f157p5': return '初始化SDK';
			case 'k_06n8uqh': return 'sdk 初始化';
			case 'k_05a3xy6': return '添加事件监听';
			case 'k_1opua40': return '事件监听应先于登录方法前添加，以防漏消息';
			case 'k_0ptv10l': return '获取服务端时间';
			case 'k_02r2v09': return 'sdk 获取服务端时间';
			case 'k_003r6vf': return '登录';
			case 'k_0z9427p': return 'sdk 登录接口，先初始化';
			case 'k_003ph6s': return '登出';
			case 'k_1wu4tcs': return '发送C2C文本消息（3.6版本已弃用）';
			case 'k_1t6awxa': return '发送C2C自定义消息（3.6版本已弃用）';
			case 'k_0pwzyvl': return '发送Group文本消息（3.6版本已弃用）';
			case 'k_1ntp677': return '发送Group自定义消息（3.6版本已弃用）';
			case 'k_1j35r5o': return '获取 SDK 版本';
			case 'k_0kt7otn': return '获取当前登录用户';
			case 'k_1v7brb7': return '获取当前登录状态';
			case 'k_0x1tylx': return '获取用户信息';
			case 'k_0elsjm2': return '创建群聊';
			case 'k_0elrwzy': return '加入群聊';
			case 'k_0elt2dt': return '退出群聊';
			case 'k_0em2iiz': return '解散群聊';
			case 'k_0qq6zvv': return '设置个人信息';
			case 'k_11deha5': return '试验性接口';
			case 'k_15a012s': return '会话模块';
			case 'k_1xdajb0': return '获取会话列表';
			case 'k_1rgdedc': return '获取会话详情';
			case 'k_0glns86': return '删除会话';
			case 'k_0xzd96m': return '设置会话为草稿';
			case 'k_0dg9tmi': return '会话置顶';
			case 'k_1vmox4p': return '获取会话未读总数';
			case 'k_15b6qz8': return '消息模块';
			case 'k_1yns1w9': return '发送文本消息';
			case 'k_0zq67yj': return '发送自定义消息';
			case 'k_1um4zaj': return '发送图片消息';
			case 'k_0bgy5ol': return '发送视频消息';
			case 'k_05gsxdv': return '发送文件消息';
			case 'k_0axzzec': return '发送录音消息';
			case 'k_02blxws': return '发送文本At消息';
			case 'k_1um3h9j': return '发送地理位置消息';
			case 'k_1x28z5r': return '发送表情消息';
			case 'k_0310ebw': return '发送合并消息';
			case 'k_00afgq7': return '发送转发消息';
			case 'k_13sdbcu': return '重发消息';
			case 'k_12w209p': return '修改本地消息（String）';
			case 'k_199jsqj': return '修改本地消息（Int）';
			case 'k_0ktebqj': return '修改云端消息（String-已弃用）';
			case 'k_0k6jqud': return '获取C2C历史消息';
			case 'k_0bf7otk': return '获取Group历史消息';
			case 'k_1fbo5v2': return '获取历史消息高级接口';
			case 'k_1asy1yf': return '获取历史消息高级接口（不格式化）';
			case 'k_13sdxko': return '撤回消息';
			case 'k_1vlsgoe': return '标记C2C会话已读';
			case 'k_17fh8gz': return '标记Group会话已读';
			case 'k_16sb1e7': return '标记所有消息为已读';
			case 'k_01q04pm': return '删除本地消息';
			case 'k_13sqfye': return '删除消息';
			case 'k_1saxzrf': return '向group中插入一条本地消息';
			case 'k_075u68x': return '向c2c会话中插入一条本地消息';
			case 'k_16tukku': return '清空单聊本地及云端的消息';
			case 'k_13z9nvj': return '获取用户消息接收选项';
			case 'k_182b8ni': return '清空群组单聊本地及云端的消息';
			case 'k_01qv9eo': return '搜索本地消息';
			case 'k_0bfyrre': return '查询指定会话中的本地消息';
			case 'k_0mz8nlf': return '好友关系链模块';
			case 'k_10ig2ml': return '获取好友列表';
			case 'k_0q5feak': return '获取好友信息';
			case 'k_16758qw': return '添加好友';
			case 'k_0q5kkj1': return '设置好友信息';
			case 'k_1666obb': return '删除好友';
			case 'k_167fad4': return '检测好友';
			case 'k_15gn1d5': return '获取好友申请列表';
			case 'k_05576s4': return '同意好友申请';
			case 'k_055cno8': return '拒绝好友申请';
			case 'k_0m517oy': return '获取黑名单列表';
			case 'k_042sv53': return '添加到黑名单';
			case 'k_1oybli5': return '从黑名单移除';
			case 'k_05jmpkg': return '创建好友分组';
			case 'k_05jnyuo': return '获取好友分组';
			case 'k_05jcbyt': return '删除好友分组';
			case 'k_14xxze4': return '重命名好友分组';
			case 'k_14kqmvu': return '添加好友到分组';
			case 'k_00mp87q': return '从分组中删除好友';
			case 'k_167cp0t': return '搜索好友';
			case 'k_15b6vqr': return '群组模块';
			case 'k_1j2fn17': return '高级创建群组';
			case 'k_16mti73': return '获取加群列表';
			case 'k_0suniq6': return '获取群信息';
			case 'k_0supwn3': return '设置群信息';
			case 'k_1ojrrgd': return '获取群在线人数';
			case 'k_1pb3f1z': return '获取群成员列表';
			case 'k_1gx3i86': return '获取群成员信息';
			case 'k_1gwzvg7': return '设置群成员信息';
			case 'k_0h1ttfs': return '禁言群成员';
			case 'k_0c9tkhn': return '邀请好友进群';
			case 'k_11yzdz7': return '踢人出群';
			case 'k_0uupir5': return '设置群角色';
			case 'k_18pxx1p': return '转移群主';
			case 'k_0r4h8ww': return '搜索群列表';
			case 'k_0h1m7ef': return '搜索群成员';
			case 'k_15az05y': return '信令模块';
			case 'k_0gzsnbo': return '发起邀请';
			case 'k_1ifjitt': return '在群组中发起邀请';
			case 'k_0qr6nnz': return '获取信令信息';
			case 'k_0hsgjrg': return '添加邀请信令';
			case 'k_1499er2': return '添加邀请信令（可以用于群离线推送消息触发的邀请信令）';
			case 'k_1rmuiim': return '离线推送模块';
			case 'k_1uobs68': return '上报推送配置';
			case 'k_18ufun0': return '注册事件';
			case 'k_0dyrkl5': return '注销simpleMsgListener事件';
			case 'k_1q2xs9c': return '注销所有simpleMsgListener事件';
			case 'k_0fyg1xs': return '注销advanceMsgListener';
			case 'k_0awkp15': return '注销所有advanceMsgListener';
			case 'k_12oryz1': return '注销signalingListener';
			case 'k_1xb912c': return '注销所有signalingListener';
			case 'k_1r092x8': return '注销gruopListener';
			case 'k_1ec07ke': return '被添加好友ID';
			case 'k_14bwl8c': return '好友备注';
			case 'k_121555d': return '好友分组';
			case 'k_0qbtor0': return '好友分组，首先得有这个分组';
			case 'k_0gavw6m': return '添加简述';
			case 'k_15ihgoz': return '好友类型';
			case 'k_1675qge': return '双向好友';
			case 'k_1675qk7': return '单向好友';
			case 'k_1eopfpu': return '选择优先级';
			case 'k_0socms9': return ({required Object addType}) => '已选：${addType}';
			case 'k_03c51e7': return '未选择';
			case 'k_0ethd0p': return '添加信令信息（选择已有的信令信息进行测试）';
			case 'k_15i526p': return '删除类型';
			case 'k_1ciwziu': return '同意添加双向好友';
			case 'k_19iuz0v': return '同意添加单向好友';
			case 'k_0ix65gm': return '选择同意类型类型';
			case 'k_14awofe': return ({required Object friendType}) => '已选：${friendType}';
			case 'k_0gw88si': return '同意申请';
			case 'k_0xxojzb': return '收到的事件回调';
			case 'k_0quw2i5': return '单选只能选一个呀';
			case 'k_002r2pl': return '单选';
			case 'k_002r1h2': return '多选';
			case 'k_0w8a6yi': return ({required Object chooseType}) => '黑名单好友选择（${chooseType}）';
			case 'k_002v9zj': return '确认';
			case 'k_003nevv': return '取消';
			case 'k_03mgr50': return '请先在好友关系链模块中添加好友';
			case 'k_1ic4dp6': return '选择黑名单好友';
			case 'k_161zzkm': return '请输入用户名';
			case 'k_00alow4': return '调用实验性接口：初始化本地数据库（您可以在SDK中自行尝试其他接口）';
			case 'k_1xogzdp': return '调用实验性接口';
			case 'k_15ijita': return '检测类型';
			case 'k_0y8ersu': return '选择检测类型';
			case 'k_1e74ake': return ({required Object checkType}) => '已选：${checkType}';
			case 'k_0iilkht': return '清空单聊本地及云端的消息（不删除会话）';
			case 'k_0szs46i': return '获取群组信息';
			case 'k_1pli0aq': return ({required Object chooseType}) => '会话选择（${chooseType}）';
			case 'k_0hqslym': return '暂无会话信息';
			case 'k_0gmqf8i': return '选择会话';
			case 'k_03eu3my': return '分组名';
			case 'k_03768rw': return '群ID';
			case 'k_1vjwjey': return '选填（如填，则自定义群ID）';
			case 'k_03agq58': return '群名称';
			case 'k_0kg1wsx': return '选择群类型';
			case 'k_0lzvumx': return 'Work 工作群';
			case 'k_0mbokjw': return 'Public 公开群';
			case 'k_028lr1o': return 'Meeting 会议群';
			case 'k_1te7y0e': return 'AVChatRoom 直播群';
			case 'k_0itcz3b': return ({required Object groupType}) => '已选：${groupType}';
			case 'k_03avhuo': return '创建群';
			case 'k_03es1ox': return '群类型';
			case 'k_0wqztai': return '群类型：Work';
			case 'k_0shjk7e': return '群类型：Public';
			case 'k_1qrpwz6': return '群类型：Meeting';
			case 'k_0jmohdb': return '群类型r：AVChatRoom';
			case 'k_03f295d': return '群通告';
			case 'k_03i9mfe': return '群简介';
			case 'k_03fchyy': return '群头像';
			case 'k_11msgmy': return '选择群头像';
			case 'k_1gyj2yl': return '是否全员禁言';
			case 'k_0zo1d5d': return '选择加群类型';
			case 'k_0o7jsdm': return ({required Object addOpt}) => '已选：${addOpt}';
			case 'k_18epku7': return '高级创建群';
			case 'k_0m7f240': return '从黑名单中移除';
			case 'k_0m3mh75': return '选择删除类型';
			case 'k_0is52zl': return ({required Object deleteType}) => '已选：${deleteType}';
			case 'k_11vvszp': return '解散群组';
			case 'k_0q8ddw7': return ({required Object chooseType}) => '好友申请选择（${chooseType}）';
			case 'k_1pyaxto': return '目前没有好友申请';
			case 'k_0556th3': return '选择好友申请';
			case 'k_1pm8o4n': return ({required Object chooseType}) => '分组选择（${chooseType}）';
			case 'k_121ewqv': return '选择分组';
			case 'k_1pmg14j': return ({required Object chooseType}) => '好友选择（${chooseType}）';
			case 'k_167dvo3': return '选择好友';
			case 'k_0q9n4ea': return ({required Object userStr}) => '要查询的用户: ${userStr}';
			case 'k_1qdxkv0': return '查询针对某个用户的 C2C 消息接收选项（免打扰状态）';
			case 'k_13v2x0e': return '获取好友分组信息';
			case 'k_0v51dmo': return ({required Object filter}) => '已选：${filter}';
			case 'k_0rnrkt5': return '获取在线人数';
			case 'k_0jd2nod': return '选择type';
			case 'k_1laca48': return ({required Object type}) => '已选：${type}';
			case 'k_1mm5bjo': return '获取历史消息高级接口（格式化数据）';
			case 'k_1b1tzii': return '获取native sdk版本号';
			case 'k_0h1otop': return '选择群成员';
			case 'k_1pm8vid': return ({required Object chooseType}) => '群组选择（${chooseType}）';
			case 'k_1ksi75r': return '请先加入群组';
			case 'k_11vv63p': return '选择群组';
			case 'k_03fglvp': return '初始化';
			case 'k_0xpwna0': return ({required Object senderStr}) => '要查询的用户: ${senderStr}';
			case 'k_132xs0u': return '发送文本';
			case 'k_17argoi': return '文本内容';
			case 'k_1qjjcx0': return '是否仅在线用户接受到消息';
			case 'k_002ws2a': return '邀请';
			case 'k_1bc6l5x': return '进群打招呼Message';
			case 'k_11vsj5s': return '加入群组';
			case 'k_0812nh1': return '踢群成员出群';
			case 'k_1uz99pq': return '标记c2c会话已读';
			case 'k_17fhxqb': return '标记group会话已读';
			case 'k_13sbhj6': return '选择消息';
			case 'k_1gw84h2': return '禁言群成员信息';
			case 'k_0mf7epf': return '会话置顶/取消置顶';
			case 'k_11vsa3j': return '退出群组';
			case 'k_0stba5l': return '别人发给我的';
			case 'k_09ezm4w': return '我发别人的';
			case 'k_0w3vj1s': return '请求类型类型';
			case 'k_16cx0kq': return '别人发给我的加好友请求';
			case 'k_07d9n7u': return '我发给别人的加好友请求';
			case 'k_15ilfmd': return '选择类型';
			case 'k_17zxeit': return ({required Object chooseType}) => '已选：${chooseType}';
			case 'k_0gw8cb2': return '拒绝申请';
			case 'k_15khfil': return '旧分组名';
			case 'k_15khfh6': return '新分组名';
			case 'k_1cgc6p5': return '搜索关键字列表，最多支持5个';
			case 'k_1csi4tv': return '关键字(example只有设置了一个关键字)';
			case 'k_0q9wh26': return '设置是否搜索userID';
			case 'k_1p7cxk7': return '是否设置搜索昵称';
			case 'k_14mm3m5': return '设置是否搜索备注';
			case 'k_03g1hin': return '关键字';
			case 'k_0xtvoya': return '设置是否搜索群成员 userID';
			case 'k_0musqvf': return '设置是否搜索群成员昵称';
			case 'k_0v2tnyc': return '设置是否搜索群成员名片';
			case 'k_0fgvqsh': return '设置是否搜索群成员备注';
			case 'k_0di7h2o': return '搜索关键字(最多支持五个，example只支持一个)';
			case 'k_139zdqj': return '设置是否搜索群 ID';
			case 'k_0rbflyz': return '设置是否搜索群名称';
			case 'k_0t9qj8k': return '搜索Group';
			case 'k_03rrahs': return '关键字(必填)';
			case 'k_0vl6shl': return '关键字（接口支持5个，example支持一个）';
			case 'k_1p5f8xt': return '查询本地消息(不指定会话不返回messageList)';
			case 'k_0wmcksi': return '自定义数据';
			case 'k_1wjd1o3': return '发送C2C自定义消息（弃用）';
			case 'k_0qqamgs': return '发送C2C文本消息（已经弃用）';
			case 'k_17ix8wi': return '自定义数据data';
			case 'k_01cqw1f': return '自定义数据desc';
			case 'k_0gmtcyj': return '自定义数据extension';
			case 'k_03b2yxe': return '优先级';
			case 'k_1qkm7de': return ({required Object priority}) => '已选：${priority}';
			case 'k_1wmh4z7': return '发送消息是否不计入未读数';
			case 'k_02nlunm': return '自定义localCustomData';
			case 'k_121pu0b': return '表情位置';
			case 'k_13mefja': return '表情信息';
			case 'k_1krj2k5': return '自定义localCustomData(File)';
			case 'k_18ni1o4': return '选择文件';
			case 'k_1bbh6rj': return '自定义localCustomData(sendForwardMessage)';
			case 'k_13sda1r': return '转发消息';
			case 'k_08lezoy': return '发送自定义数据';
			case 'k_05wotoe': return '发送Group自定义消息(弃用)';
			case 'k_0ayxzy6': return '发送Group文本消息（已弃用）';
			case 'k_0kotqjn': return '自定义localCustomData(sendImageMessage)';
			case 'k_111hdgc': return '选择图片';
			case 'k_060rdwo': return '地理位置消息描述';
			case 'k_0lbz4k9': return '自定义localCustomData(sendLocationMessage)';
			case 'k_1qpk5nl': return '获取当前地理位置信息';
			case 'k_0yn59ns': return 'XXX与XXX的会话';
			case 'k_1k1pnl2': return '低版本不支持会会收到文本消息';
			case 'k_07uflzi': return '自定义localCustomData(sendMergerMessage)';
			case 'k_13sgi0s': return '合并消息';
			case 'k_09inq13': return '自定义localCustomData(sendSoundMessage)';
			case 'k_0svi3rz': return '删除文件成功';
			case 'k_0bt4pm7': return '结束录音';
			case 'k_0bt6ctk': return '开始录音';
			case 'k_03eztxo': return '未录制';
			case 'k_19xq0ad': return '自定义localCustomData(sendVideoMessage)';
			case 'k_0d6yawi': return '选择视频';
			case 'k_13qknk5': return '云端数据';
			case 'k_0wnmtb3': return '云端修改消息（String）';
			case 'k_09qx4fw': return '草稿内容，null为取消';
			case 'k_1y65mf8': return '设置草稿/取消草稿';
			case 'k_1f4rg84': return '设置会话草稿';
			case 'k_02my10h': return '群角色';
			case 'k_0uuoz6p': return '选择群角色';
			case 'k_16owmwk': return ({required Object role}) => '已选：${role}';
			case 'k_1qe4r7d': return '设置群成员角色';
			case 'k_0wng8yl': return '本地修改消息（String）';
			case 'k_1go5et7': return '本地修改消息（Int）';
			case 'k_15wdhxq': return '注册成功';
			case 'k_0yj1my7': return '证书id';
			case 'k_18e393e': return '控制台上传证书返回的id';
			case 'k_0003v6a': return '男';
			case 'k_00043x2': return '女';
			case 'k_0ghstt4': return '允许所有人加我好友';
			case 'k_1b3mn6t': return '不允许所有人加我好友';
			case 'k_1mo5v9d': return '加我好友许我确认';
			case 'k_003lhvk': return '昵称';
			case 'k_003q1na': return '签名';
			case 'k_1hgdu7c': return '生日(int类型，不要输入字符串)';
			case 'k_003m6hr': return '生日';
			case 'k_003qgkp': return '性别';
			case 'k_15xu6ax': return '选择性别';
			case 'k_1pgjz7s': return '加好友验证方式';
			case 'k_0r291dl': return '加我好友需我确认';
			case 'k_16vvwv0': return ({required Object chooseAllowType}) => '已选：${chooseAllowType}';
			case 'k_003qk66': return '头像';
			case 'k_161i8im': return '选择头像';
			case 'k_003l8z3': return '提示';
			case 'k_142aglh': return '检测到您还未配置应用信息，请先配置';
			case 'k_03bd50d': return '去配置';
			case 'k_13m956w': return '配置信息';
			case 'k_1prb9on': return 'sdkappid，控制台去申请';
			case 'k_1fen6m9': return 'secret，控制台去申请';
			case 'k_1xp25m6': return 'userID，随便填';
			case 'k_12clf4v': return '确认设置';
			case 'k_0um8vqm': return '清除所有配置';
			case 'k_152jijg': return '添加字段';
			case 'k_0jbia4f': return '已设置字段：';
			case 'k_0md2ud6': return '字段名不能为空';
			case 'k_05nspni': return '自定义字段';
			case 'k_03eyrxm': return '字段名';
			case 'k_181l8gl': return '请在控制台查看';
			case 'k_03fj93v': return '字段值';
			case 'k_003rzap': return '确定';
			case 'k_0f2heqk': return 'code=0 业务成功 code!=0 业务失败，请在腾讯云即时通信文档文档查看对应的错误码信息。\n';
			case 'k_0hzbevw': return ({required Object type}) => '${type}触发\n';
			default: return null;
		}
	}
}
