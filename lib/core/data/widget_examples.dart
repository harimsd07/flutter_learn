class DemoExample {
  final String name;
  final String code;

  const DemoExample({
    required this.name,
    required this.code,
  });
}

final Map<String, List<DemoExample>> widgetExamplesRegistry = {
  'text-widget': [
    const DemoExample(
      name: 'Stylized Title',
      code: '''
Text(
  'Featured Topic',
  style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    color: Colors.deepPurple,
    letterSpacing: 2.0,
    shadows: [
      Shadow(
        blurRadius: 8.0,
        color: Colors.black38,
        offset: Offset(2.0, 2.0),
      ),
    ],
  ),
)''',
    ),
    const DemoExample(
      name: 'Body Paragraph style',
      code: '''
Text(
  'This is a custom styled body paragraph designed to demonstrate proper line spacing, typography weight, color palettes, and text alignment in Flutter.',
  style: TextStyle(
    fontSize: 15,
    height: 1.8,
    color: Colors.blueGrey,
    fontStyle: FontStyle.italic,
  ),
  textAlign: TextAlign.justify,
)''',
    ),
  ],
  'row-column-widget': [
    const DemoExample(
      name: 'Horizontal Badges Row',
      code: '''
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Chip(
      avatar: CircleAvatar(child: Text('A')),
      label: Text('Beginner'),
      backgroundColor: Colors.tealAccent.shade100,
    ),
    Chip(
      avatar: CircleAvatar(child: Text('B')),
      label: Text('Intermediate'),
      backgroundColor: Colors.orangeAccent.shade100,
    ),
  ],
)''',
    ),
    const DemoExample(
      name: 'Vertical Profile Card Column',
      code: '''
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    CircleAvatar(
      radius: 40,
      backgroundColor: Colors.blue,
      child: Icon(Icons.person, size: 40, color: Colors.white),
    ),
    SizedBox(height: 12),
    Text('John Doe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    SizedBox(height: 4),
    Text('Software Engineer', style: TextStyle(color: Colors.grey)),
  ],
)''',
    ),
  ],
  'container-widget': [
    const DemoExample(
      name: 'Gradient Glass Card',
      code: '''
Container(
  width: 250,
  height: 150,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.purple, Colors.blue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.purple.withOpacity(0.3),
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  ),
  alignment: Alignment.center,
  child: Text(
    'Interactive Container',
    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
  ),
)''',
    ),
    const DemoExample(
      name: 'Circular Badge Button',
      code: '''
Container(
  width: 100,
  height: 100,
  decoration: BoxDecoration(
    color: Colors.amber,
    shape: BoxShape.circle,
    border: Border.all(color: Colors.white, width: 4),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Icon(Icons.star, size: 50, color: Colors.white),
)''',
    ),
  ],
  'center-widget': [
    const DemoExample(
      name: 'Centered Action Button',
      code: '''
Center(
  child: ElevatedButton.icon(
    onPressed: () {},
    icon: Icon(Icons.send_rounded),
    label: Text('Send Message'),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
)''',
    ),
  ],
  'padding-widget': [
    const DemoExample(
      name: 'Asymmetric Card Padding',
      code: '''
Padding(
  padding: EdgeInsets.only(left: 32.0, top: 16.0, right: 8.0, bottom: 24.0),
  child: Card(
    color: Colors.teal.shade50,
    child: ListTile(
      title: Text('Custom Padding spacing'),
      subtitle: Text('Observe asymmetric edge gaps'),
    ),
  ),
)''',
    ),
  ],
  'sizedbox-widget': [
    const DemoExample(
      name: 'Fixed Dimension box',
      code: '''
SizedBox(
  width: 220,
  height: 80,
  child: Card(
    color: Colors.redAccent,
    child: Center(
      child: Text('220 x 80 Space Box', style: TextStyle(color: Colors.white)),
    ),
  ),
)''',
    ),
  ],
  'expanded-widget': [
    const DemoExample(
      name: 'Proportional flex splits',
      code: '''
Row(
  children: [
    Expanded(
      flex: 1,
      child: Container(color: Colors.red, height: 100, child: Center(child: Text('Flex 1'))),
    ),
    Expanded(
      flex: 2,
      child: Container(color: Colors.blue, height: 100, child: Center(child: Text('Flex 2'))),
    ),
  ],
)''',
    ),
  ],
  'stack-positioned-widget': [
    const DemoExample(
      name: 'Notification Badge',
      code: '''
Stack(
  clipBehavior: Clip.none,
  children: [
    Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.notifications, size: 40, color: Colors.blueGrey),
    ),
    Positioned(
      top: -4,
      right: -4,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Text(
          '3',
          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  ],
)''',
    ),
  ],
  'scaffold-widget': [
    const DemoExample(
      name: 'Interactive Scaffold',
      code: '''
Scaffold(
  appBar: AppBar(title: Text('Material Scaffold')),
  body: Center(child: Text('Body content here')),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)''',
    ),
  ],
  'appbar-widget': [
    const DemoExample(
      name: 'Action items AppBar',
      code: '''
AppBar(
  leading: Icon(Icons.menu),
  title: Text('Custom AppBar'),
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
  ],
  backgroundColor: Colors.blueAccent,
)''',
    ),
  ],
  'fab-widget': [
    const DemoExample(
      name: 'Extended FAB layout',
      code: '''
FloatingActionButton.extended(
  onPressed: () {},
  label: Text('Create Task'),
  icon: Icon(Icons.add_task),
  backgroundColor: Colors.deepOrange,
)''',
    ),
  ],
  'card-widget': [
    const DemoExample(
      name: 'Elevation shadow Card',
      code: '''
Card(
  elevation: 8.0,
  shadowColor: Colors.purpleAccent,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  child: Padding(
    padding: EdgeInsets.all(24.0),
    child: Text('Card with Custom elevation and shadow color'),
  ),
)''',
    ),
  ],
  'listtile-widget': [
    const DemoExample(
      name: 'Rich Tile properties',
      code: '''
ListTile(
  leading: CircleAvatar(child: Icon(Icons.headset)),
  title: Text('Flutter Audio Tracks'),
  subtitle: Text('Format: MP3 | Bitrate: 320 kbps'),
  trailing: Icon(Icons.play_arrow),
  isThreeLine: true,
)''',
    ),
  ],
  'bottomnav-widget': [
    const DemoExample(
      name: 'Bottom nav items display',
      code: '''
BottomNavigationBar(
  currentIndex: 0,
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ],
)''',
    ),
  ],
  'snackbar-widget': [
    const DemoExample(
      name: 'Action Snack bar',
      code: '''
SnackBar(
  content: Text('Profile details updated'),
  action: SnackBarAction(label: 'Undo', onPressed: () {}),
  duration: Duration(seconds: 4),
)''',
    ),
  ],
  'alertdialog-widget': [
    const DemoExample(
      name: 'Selection Action dialog',
      code: '''
AlertDialog(
  title: Text('Confirm deletion?'),
  content: Text('Are you sure you want to delete this folder permanently?'),
  actions: [
    TextButton(onPressed: () {}, child: Text('Cancel')),
    TextButton(onPressed: () {}, child: Text('Delete', style: TextStyle(color: Colors.red))),
  ],
)''',
    ),
  ],
  'textfield-widget': [
    const DemoExample(
      name: 'Password visibility style',
      code: '''
TextField(
  obscureText: true,
  decoration: InputDecoration(
    labelText: 'Enter Password',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.lock),
    suffixIcon: Icon(Icons.visibility),
  ),
)''',
    ),
  ],
  'textformfield-widget': [
    const DemoExample(
      name: 'Form validator style',
      code: '''
TextFormField(
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    labelText: 'Email Address',
    hintText: 'user@example.com',
    border: UnderlineInputBorder(),
  ),
)''',
    ),
  ],
  'checkbox-widget': [
    const DemoExample(
      name: 'Custom active color Checkbox',
      code: '''
Checkbox(
  value: true,
  onChanged: (val) {},
  activeColor: Colors.deepPurple,
  checkColor: Colors.amber,
)''',
    ),
  ],
  'radio-widget': [
    const DemoExample(
      name: 'Radio group choices',
      code: '''
Column(
  children: [
    RadioListTile(value: 1, groupValue: 1, onChanged: (val) {}, title: Text('Choice A')),
    RadioListTile(value: 2, groupValue: 1, onChanged: (val) {}, title: Text('Choice B')),
  ],
)''',
    ),
  ],
  'switch-widget': [
    const DemoExample(
      name: 'Colored Switch slider',
      code: '''
Switch(
  value: true,
  onChanged: (val) {},
  activeColor: Colors.emerald ?? Colors.green,
  activeTrackColor: Colors.green.shade100,
)''',
    ),
  ],
  'slider-widget': [
    const DemoExample(
      name: 'Discrete slider selections',
      code: '''
Slider(
  value: 4.0,
  min: 1.0,
  max: 5.0,
  divisions: 4,
  label: 'discrete slider',
  onChanged: (val) {},
)''',
    ),
  ],
  'dropdown-widget': [
    const DemoExample(
      name: 'Custom list dropdown',
      code: '''
DropdownButton<String>(
  value: 'Medium',
  items: ['Low', 'Medium', 'High'].map((String val) {
    return DropdownMenuItem<String>(value: val, child: Text(val));
  }).toList(),
  onChanged: (val) {},
)''',
    ),
  ],
  'gesturedetector-widget': [
    const DemoExample(
      name: 'Double tap zoom box',
      code: '''
GestureDetector(
  onDoubleTap: () {},
  child: Container(
    padding: EdgeInsets.all(24),
    color: Colors.blueGrey,
    child: Text('Double Tap to Zoom', style: TextStyle(color: Colors.white)),
  ),
)''',
    ),
  ],
  'inkwell-widget': [
    const DemoExample(
      name: 'Custom splash color splash',
      code: '''
InkWell(
  onTap: () {},
  splashColor: Colors.pinkAccent.withOpacity(0.5),
  highlightColor: Colors.transparent,
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    child: Text('Custom Splash InkWell'),
  ),
)''',
    ),
  ],
  'listview-widget': [
    const DemoExample(
      name: 'Horizontal List View',
      code: '''
ListView(
  scrollDirection: Axis.horizontal,
  children: [
    Container(width: 120, color: Colors.blue, child: Center(child: Text('Card A'))),
    Container(width: 120, color: Colors.purple, child: Center(child: Text('Card B'))),
  ],
)''',
    ),
  ],
  'gridview-widget': [
    const DemoExample(
      name: 'Flexible aspect Grid',
      code: '''
GridView.count(
  crossAxisCount: 3,
  childAspectRatio: 1.5,
  children: [
    Container(color: Colors.blue, margin: EdgeInsets.all(4)),
    Container(color: Colors.green, margin: EdgeInsets.all(4)),
  ],
)''',
    ),
  ],
  'reorderable-listview-widget': [
    const DemoExample(
      name: 'Reorderable numbers list',
      code: '''
ReorderableListView(
  children: [
    ListTile(key: ValueKey('1'), title: Text('Number 1')),
    ListTile(key: ValueKey('2'), title: Text('Number 2')),
  ],
  onReorder: (oldIndex, newIndex) {},
)''',
    ),
  ],
  'sliver-widget': [
    const DemoExample(
      name: 'Custom Sliver list layout',
      code: '''
CustomScrollView(
  slivers: [
    SliverAppBar(title: Text('Sliver Header')),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('Item \$index')),
        childCount: 5,
      ),
    ),
  ],
)''',
    ),
  ],
  'tabbar-widget': [
    const DemoExample(
      name: 'Top Navigation Tabs',
      code: '''
TabBar(
  tabs: [
    Tab(icon: Icon(Icons.home), text: 'Home'),
    Tab(icon: Icon(Icons.settings), text: 'Settings'),
  ],
)''',
    ),
  ],
  'pageview-widget': [
    const DemoExample(
      name: 'Vertical Page View swipe',
      code: '''
PageView(
  scrollDirection: Axis.vertical,
  children: [
    Container(color: Colors.orange, child: Center(child: Text('Page 1'))),
    Container(color: Colors.teal, child: Center(child: Text('Page 2'))),
  ],
)''',
    ),
  ],
  'navigationrail-widget': [
    const DemoExample(
      name: 'Extended navigation rail',
      code: '''
NavigationRail(
  extended: true,
  selectedIndex: 0,
  destinations: [
    NavigationRailDestination(icon: Icon(Icons.chat), label: Text('Chats')),
    NavigationRailDestination(icon: Icon(Icons.people), label: Text('Users')),
  ],
  onDestinationSelected: (val) {},
)''',
    ),
  ],
  'animatedcontainer-widget': [
    const DemoExample(
      name: 'Custom curve animation',
      code: '''
AnimatedContainer(
  duration: Duration(milliseconds: 800),
  curve: Curves.elasticOut,
  width: 150,
  height: 150,
  color: Colors.blueAccent,
)''',
    ),
  ],
  'animatedopacity-widget': [
    const DemoExample(
      name: 'Slow fading opacity',
      code: '''
AnimatedOpacity(
  opacity: 0.8,
  duration: Duration(seconds: 2),
  child: FlutterLogo(size: 60),
)''',
    ),
  ],
  'hero-widget': [
    const DemoExample(
      name: 'Product image Hero fly',
      code: '''
Hero(
  tag: 'product-hero-key',
  child: Icon(Icons.shopping_bag, size: 80, color: Colors.blue),
)''',
    ),
  ],
  'setstate-demo': [
    const DemoExample(
      name: 'Count Decrementer counter',
      code: '''
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('Decrementor Counter demo'),
    ElevatedButton(
      onPressed: () {},
      child: Text('Decrement count'),
    ),
  ],
)''',
    ),
  ],
  'valuenotifier-demo': [
    const DemoExample(
      name: 'Light Dark Theme toggle',
      code: '''
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('ValueNotifier Theme Demo'),
    IconButton(
      icon: Icon(Icons.lightbulb_outline),
      onPressed: () {},
    ),
  ],
)''',
    ),
  ],
  'cupertino-button-widget': [
    const DemoExample(
      name: 'Cupertino filled button Style',
      code: '''
CupertinoButton.filled(
  onPressed: () {},
  child: Text('Filled Button'),
)''',
    ),
  ],
  'cupertino-textfield-widget': [
    const DemoExample(
      name: 'iOS styled search text field',
      code: '''
CupertinoSearchTextField(
  placeholder: 'Search Apple Music...',
)''',
    ),
  ],
  'cupertino-alertdialog-widget': [
    const DemoExample(
      name: 'Standard iOS Action alert',
      code: '''
CupertinoAlertDialog(
  title: Text('Access Device Contacts?'),
  content: Text('We need permissions to access your phone book contacts.'),
  actions: [
    CupertinoDialogAction(child: Text('Reject')),
    CupertinoDialogAction(child: Text('Allow'), isDefaultAction: true),
  ],
)''',
    ),
  ],
  'cupertino-switch-widget': [
    const DemoExample(
      name: 'iOS theme toggle Switch',
      code: '''
CupertinoSwitch(
  value: false,
  onChanged: (val) {},
  activeColor: Colors.deepPurple,
)''',
    ),
  ],
  'cupertino-navbar-widget': [
    const DemoExample(
      name: 'Trailing Action navigation bar',
      code: '''
CupertinoNavigationBar(
  middle: Text('iOS Profile Settings'),
  trailing: Icon(CupertinoIcons.share),
)''',
    ),
  ],
  'futurebuilder-demo': [
    const DemoExample(
      name: 'Mock weather data loader',
      code: '''
Column(
  children: [
    Text('Fetch Weather Data (Mocked Future)'),
    Icon(Icons.cloud_download, size: 48, color: Colors.blue),
  ],
)''',
    ),
  ],
  'streambuilder-demo': [
    const DemoExample(
      name: 'Countdown stream tick',
      code: '''
Column(
  children: [
    Text('Countdown Stream (Mocked Stream)'),
    CircularProgressIndicator(),
  ],
)''',
    ),
  ],
  'http-get-demo': [
    const DemoExample(
      name: 'HTTP post list loader',
      code: '''
Column(
  children: [
    Text('Load JSON Posts from Remote endpoint'),
    Icon(Icons.network_ping, size: 40),
  ],
)''',
    ),
  ],
  'mediaquery-demo': [
    const DemoExample(
      name: 'Text scale factor info',
      code: '''
Column(
  children: [
    Text('Display Custom Scale factors and details'),
    Icon(Icons.aspect_ratio_rounded, size: 30),
  ],
)''',
    ),
  ],
  'layoutbuilder-demo': [
    const DemoExample(
      name: 'Grid and Column auto layout builder',
      code: '''
LayoutBuilder(
  builder: (context, constraints) {
    return Text('Max width constraint: \${constraints.maxWidth}');
  },
)''',
    ),
  ],
};
