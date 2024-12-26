import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ScholarshipsScreen extends StatefulWidget {
  @override
  _ScholarshipsScreenState createState() => _ScholarshipsScreenState();
}

class _ScholarshipsScreenState extends State<ScholarshipsScreen> {
  final _apiService = ApiService();
  List<dynamic> _scholarships = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadScholarships();
  }

  void _loadScholarships() async {
    try {
      final becas = await _apiService.getAllScholarships();
      setState(() {
        _scholarships = becas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Becas')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _scholarships.isEmpty
              ? Center(child: Text('No hay becas disponibles.'))
              : ListView.builder(
                  itemCount: _scholarships.length,
                  itemBuilder: (context, index) {
                    final beca = _scholarships[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          beca['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image_not_supported);
                          },
                        ),
                        title: Text(
                          beca['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              beca['description'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'País: ${beca['country']}',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Continente: ${beca['continent']}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            _showDetailsDialog(beca);
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  void _showDetailsDialog(Map<String, dynamic> beca) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(beca['title']),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  beca['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported, size: 100);
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  beca['description'],
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fecha: ${DateTime.parse(beca['date']).toLocal()}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text('País: ${beca['country']}'),
                Text('Continente: ${beca['continent']}'),
                const SizedBox(height: 8),
                Text('Requisitos:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...beca['requirements'].map<Widget>((req) {
                  return Text('- ${req['name']}');
                }).toList(),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _openMoreInfo(beca['moreInfo']);
                  },
                  child: Text('Más información'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _openMoreInfo(String url) {
    // Implementar navegación al enlace en la web o un widget WebView
    print('Abrir enlace: $url');
  }
}
