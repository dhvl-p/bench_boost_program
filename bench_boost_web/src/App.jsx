import React, { useState, useEffect, useRef } from 'react';
import { 
  ArrowLeft, 
  Globe, 
  Maximize2, 
  Cpu, 
  MessageSquare, 
  ShoppingCart, 
  Share2, 
  Layers, 
  Image as ImageIcon, 
  Database,
  RefreshCw,
  Send,
  Trash2,
  Check,
  CheckCheck,
  Clock,
  Plus,
  Minus,
  AlertCircle
} from 'lucide-react';
import { translations } from './translations';

// Helper for loading icons dynamically based on string names
const getIconComponent = (iconName) => {
  switch (iconName) {
    case 'headphones': return <Layers size={24} />;
    case 'watch': return <Cpu size={24} />;
    case 'mouse': return <Cpu size={24} />;
    case 'keyboard': return <Cpu size={24} />;
    case 'speaker': return <MessageSquare size={24} />;
    case 'monitor': return <Maximize2 size={24} />;
    default: return <Layers size={24} />;
  }
};

export default function App() {
  const [lang, setLang] = useState('en');
  const [currentScreen, setCurrentScreen] = useState('home');
  const [cartItems, setCartItems] = useState([]);
  const [toasts, setToasts] = useState([]);

  // Translation Helper
  const t = (key, params = {}) => {
    let text = translations[lang]?.[key] || key;
    Object.keys(params).forEach(p => {
      text = text.replace(`{${p}}`, params[p]);
    });
    return text;
  };

  // Add toast notification helper
  const showToast = (message) => {
    const id = Date.now();
    setToasts(prev => [...prev, { id, message }]);
    setTimeout(() => {
      setToasts(prev => prev.filter(toast => toast.id !== id));
    }, 3000);
  };

  const toggleLanguage = () => {
    setLang(prev => (prev === 'en' ? 'hi' : 'en'));
  };

  const navigateTo = (screen) => {
    setCurrentScreen(screen);
  };

  return (
    <div className="app-container">
      {/* Header Bar */}
      <header className="app-header">
        <div className="logo-container" onClick={() => navigateTo('home')}>
          <div className="logo-icon">
            <Cpu size={20} />
          </div>
          <span className="logo-text">{t('app_title')}</span>
        </div>
        <div className="header-actions">
          {currentScreen !== 'home' && (
            <button className="btn btn-outline btn-icon" onClick={() => navigateTo('home')}>
              <ArrowLeft size={18} />
            </button>
          )}
          <button className="lang-toggle" onClick={toggleLanguage}>
            <Globe size={16} />
            <span>{t(lang === 'en' ? 'lang_toggle_to_hindi' : 'lang_toggle_to_english')}</span>
          </button>
        </div>
      </header>

      {/* Main Content Area */}
      <main style={{ flexGrow: 1, display: 'flex', flexDirection: 'column' }}>
        {currentScreen === 'home' && <HomeScreen navigateTo={navigateTo} t={t} />}
        {currentScreen === 'provider' && <ProviderScreen t={t} />}
        {currentScreen === 'riverpod' && <RiverpodScreen t={t} />}
        {currentScreen === 'getx_photos' && <PhotosScreen mode="getx" t={t} />}
        {currentScreen === 'mobx_photos' && <PhotosScreen mode="mobx" t={t} />}
        {currentScreen === 'graphql_photos' && <GraphQLPhotosScreen t={t} />}
        {currentScreen === 'isolates' && <IsolatesScreen t={t} />}
        {currentScreen === 'websocket' && <WebSocketScreen t={t} />}
        {currentScreen === 'lifting_state' && (
          <LiftingStateScreen 
            cartItems={cartItems} 
            setCartItems={setCartItems} 
            showToast={showToast} 
            t={t} 
          />
        )}
      </main>

      {/* Toast Notifications */}
      <div className="toast-container">
        {toasts.map(toast => (
          <div key={toast.id} className="toast">
            {toast.message}
          </div>
        ))}
      </div>
    </div>
  );
}

/* =============================================================================
   1. HOME SCREEN (DASHBOARD)
   ============================================================================= */
function HomeScreen({ navigateTo, t }) {
  const menuItems = [
    { id: 'provider', badge: 'badge-provider', badgeText: 'Provider', title: 'nav_provider', desc: 'Simulates single comments state loader via REST API.', icon: <Database size={24} /> },
    { id: 'riverpod', badge: 'badge-riverpod', badgeText: 'Riverpod', title: 'nav_riverpod', desc: 'Simulates posts list container with pull-to-refresh style action.', icon: <Layers size={24} /> },
    { id: 'getx_photos', badge: 'badge-getx', badgeText: 'GetX REST', title: 'nav_getx_photos', desc: 'Grid of photos fetched from JSONPlaceholder using REST API.', icon: <ImageIcon size={24} /> },
    { id: 'mobx_photos', badge: 'badge-mobx', badgeText: 'MobX REST', title: 'nav_mobx_photos', desc: 'Grid of photos fetched from JSONPlaceholder using MobX style reactions.', icon: <ImageIcon size={24} /> },
    { id: 'graphql_photos', badge: 'badge-getx', badgeText: 'GetX GraphQL', title: 'nav_getx_graphql', desc: 'GraphQL photos fetched using GraphQLZero API queries.', icon: <Share2 size={24} /> },
    { id: 'isolates', badge: 'badge-performance', badgeText: 'Isolates', title: 'nav_isolates', desc: 'Runs CPU-heavy calculations on main thread vs background Web Worker.', icon: <Cpu size={24} /> },
    { id: 'websocket', badge: 'badge-state', badgeText: 'WebSocket', title: 'nav_websocket', desc: 'Polished messaging interface connected to echo servers.', icon: <MessageSquare size={24} /> },
    { id: 'lifting_state', badge: 'badge-state', badgeText: 'Lifting State', title: 'nav_lifting_state', desc: 'Synchronized shop catalog and details screens sharing state.', icon: <ShoppingCart size={24} /> },
  ];

  return (
    <div className="dashboard">
      <div className="dashboard-hero">
        <h1 className="dashboard-title">{t('app_title')}</h1>
        <p className="dashboard-tagline">{t('splash_tagline')}</p>
      </div>
      <div className="menu-grid">
        {menuItems.map(item => (
          <div key={item.id} className="menu-card" onClick={() => navigateTo(item.id)}>
            <div className={`badge-pill ${item.badge}`}>{item.badgeText}</div>
            <div className="menu-card-icon">{item.icon}</div>
            <h3 className="menu-card-title">{t(item.title)}</h3>
            <p className="menu-card-desc">{item.desc}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

/* =============================================================================
   2. PROVIDER SCREEN (SINGLE COMMENT)
   ============================================================================= */
function ProviderScreen({ t }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchData = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('https://jsonplaceholder.typicode.com/comments/1');
      if (!res.ok) throw new Error('Failed to fetch comment');
      const json = await res.json();
      setData(json);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <div className="screen-container">
      <div className="screen-header">
        <div className="screen-title-area">
          <span className="badge-pill badge-provider">Provider</span>
          <h2 className="screen-title">{t('provider_app_bar_title')}</h2>
        </div>
        <button className="btn btn-outline" onClick={fetchData} disabled={loading}>
          <RefreshCw size={16} className={loading ? 'spin' : ''} />
        </button>
      </div>

      <div className="screen-card-panel" style={{ flexGrow: 1, display: 'flex', flexDirection: 'column', justifyContent: 'center', minHeight: '300px' }}>
        {loading ? (
          <div className="spinner" />
        ) : error ? (
          <div style={{ textAlign: 'center' }}>
            <AlertCircle size={48} color="var(--accent-error)" style={{ marginBottom: '1rem' }} />
            <p style={{ marginBottom: '1.5rem', color: 'var(--text-secondary)' }}>{error}</p>
            <button className="btn btn-primary" onClick={fetchData}>{t('retry')}</button>
          </div>
        ) : (
          <div style={{ animation: 'slide-up 0.4s ease-out' }}>
            <h3 style={{ fontSize: '1.5rem', marginBottom: '1.5rem', borderBottom: '1px solid var(--border-glass)', paddingBottom: '0.75rem', textTransform: 'capitalize' }}>
              {data.name}
            </h3>
            <p style={{ color: 'var(--text-secondary)', lineHeight: '1.8', fontSize: '1.1rem' }}>
              {data.body}
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

/* =============================================================================
   3. RIVERPOD SCREEN (POSTS LIST)
   ============================================================================= */
function RiverpodScreen({ t }) {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchPosts = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('https://jsonplaceholder.typicode.com/posts');
      if (!res.ok) throw new Error('Failed to fetch posts');
      const json = await res.json();
      setPosts(json.slice(0, 15)); // Limit to first 15 posts for clean rendering
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchPosts();
  }, []);

  return (
    <div className="screen-container">
      <div className="screen-header">
        <div className="screen-title-area">
          <span className="badge-pill badge-riverpod">Riverpod</span>
          <h2 className="screen-title">{t('riverpod_app_bar_title')}</h2>
        </div>
        <button className="btn btn-outline" onClick={fetchPosts} disabled={loading}>
          <RefreshCw size={16} className={loading ? 'spin' : ''} />
        </button>
      </div>

      <div className="screen-card-panel" style={{ flexGrow: 1, padding: '1.5rem', display: 'flex', flexDirection: 'column', height: '60vh' }}>
        {loading ? (
          <div style={{ margin: 'auto' }} className="spinner" />
        ) : error ? (
          <div style={{ margin: 'auto', textAlign: 'center' }}>
            <AlertCircle size={48} color="var(--accent-error)" style={{ marginBottom: '1rem' }} />
            <p style={{ marginBottom: '1.5rem', color: 'var(--text-secondary)' }}>{error}</p>
            <button className="btn btn-primary" onClick={fetchPosts}>{t('retry')}</button>
          </div>
        ) : (
          <div style={{ overflowY: 'auto', flexGrow: 1, display: 'flex', flexDirection: 'column', gap: '1rem' }}>
            {posts.map((post, idx) => (
              <div 
                key={post.id} 
                style={{ 
                  padding: '1.25rem', 
                  borderBottom: idx === posts.length - 1 ? 'none' : '1px solid var(--border-glass)', 
                  animation: 'slide-up 0.3s ease-out' 
                }}
              >
                <h4 style={{ color: 'var(--text-primary)', marginBottom: '0.5rem', fontSize: '1.1rem', textTransform: 'capitalize' }}>
                  {post.title}
                </h4>
                <p style={{ color: 'var(--text-secondary)', fontSize: '0.925rem', lineHeight: '1.5' }}>
                  {post.body}
                </p>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

/* =============================================================================
   4. GETX & MOBX REST PHOTOS GRID
   ============================================================================= */
function PhotosScreen({ mode, t }) {
  const [photos, setPhotos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [selectedPhoto, setSelectedPhoto] = useState(null);

  const fetchPhotos = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('https://jsonplaceholder.typicode.com/photos?_limit=24');
      if (!res.ok) throw new Error('Failed to fetch photos');
      const json = await res.json();
      setPhotos(json);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchPhotos();
  }, []);

  const badgeClass = mode === 'getx' ? 'badge-getx' : 'badge-mobx';
  const themeTitle = mode === 'getx' ? t('getx_app_bar_title') : t('mobx_app_bar_title');
  const powerLabel = mode === 'getx' ? t('powered_by_getx') : t('powered_by_mobx');

  return (
    <div className="screen-container">
      <div className="screen-header">
        <div className="screen-title-area">
          <span className={`badge-pill ${badgeClass}`}>{mode.toUpperCase()}</span>
          <h2 className="screen-title">{themeTitle}</h2>
        </div>
        <button className="btn btn-outline" onClick={fetchPhotos} disabled={loading}>
          <RefreshCw size={16} className={loading ? 'spin' : ''} />
        </button>
      </div>

      <div className="screen-card-panel" style={{ flexGrow: 1, display: 'flex', flexDirection: 'column' }}>
        {loading ? (
          <div style={{ margin: 'auto' }} className="spinner spinner-gold" />
        ) : error ? (
          <div style={{ margin: 'auto', textAlign: 'center' }}>
            <AlertCircle size={48} color="var(--accent-error)" style={{ marginBottom: '1rem' }} />
            <p style={{ marginBottom: '1.5rem', color: 'var(--text-secondary)' }}>{error}</p>
            <button className="btn btn-primary" onClick={fetchPhotos}>{t('retry')}</button>
          </div>
        ) : (
          <>
            <div className="photo-stats-bar">
              <span style={{ fontWeight: 600, color: 'var(--accent-secondary)' }}>
                {t('photos_count', { count: photos.length })}
              </span>
              <span style={{ fontStyle: 'italic', color: 'var(--text-muted)' }}>{powerLabel}</span>
            </div>

            <div className="photo-grid">
              {photos.map(photo => (
                <div key={photo.id} className="photo-card" onClick={() => setSelectedPhoto(photo)}>
                  <span className="photo-card-id">#{photo.id}</span>
                  <div className="photo-card-img-wrapper">
                    <img src={photo.thumbnailUrl} alt={photo.title} className="photo-card-img" loading="lazy" />
                  </div>
                  <div className="photo-card-content">
                    <h4 className="photo-card-title">{photo.title}</h4>
                    <div className="photo-card-album">
                      <Layers size={11} />
                      <span>Album {photo.albumId}</span>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </>
        )}
      </div>

      {/* Photo Detail Modal */}
      {selectedPhoto && (
        <PhotoModal photo={selectedPhoto} onClose={() => setSelectedPhoto(null)} t={t} />
      )}
    </div>
  );
}

function PhotoModal({ photo, onClose, t }) {
  return (
    <div className="modal-backdrop" onClick={onClose}>
      <div className="modal-content" onClick={e => e.stopPropagation()}>
        <div className="modal-img-wrapper">
          <img src={photo.url} alt={photo.title} className="modal-img" />
        </div>
        <div className="modal-body">
          <div className="modal-badges">
            <span className="modal-badge modal-badge-yellow">Photo #{photo.id}</span>
            <span className="modal-badge modal-badge-blue">Album {photo.albumId}</span>
          </div>
          <h3 className="modal-title">{photo.title}</h3>
          <button className="btn btn-primary modal-close-btn" onClick={onClose}>{t('ok')}</button>
        </div>
      </div>
    </div>
  );
}

/* =============================================================================
   5. GETX GRAPHQL PHOTOS GRID
   ============================================================================= */
function GraphQLPhotosScreen({ t }) {
  const [photos, setPhotos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [selectedPhoto, setSelectedPhoto] = useState(null);

  const fetchGraphQLPhotos = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch('https://graphqlzero.almansi.me/api', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          query: `
            query GetPhotos($limit: Int) {
              photos(options: { paginate: { limit: $limit } }) {
                data {
                  id
                  title
                  url
                  thumbnailUrl
                  album {
                    id
                  }
                }
              }
            }
          `,
          variables: { limit: 20 }
        })
      });

      const result = await response.json();
      if (result.errors) {
        throw new Error(result.errors[0].message);
      }
      
      const data = result.data?.photos?.data || [];
      const formatted = data.map(item => ({
        id: parseInt(item.id) || 0,
        title: item.title || '',
        url: item.url || '',
        thumbnailUrl: item.thumbnailUrl || '',
        albumId: parseInt(item.album?.id) || 0
      }));

      setPhotos(formatted);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchGraphQLPhotos();
  }, []);

  return (
    <div className="screen-container">
      <div className="screen-header">
        <div className="screen-title-area">
          <span className="badge-pill badge-getx">GraphQL</span>
          <h2 className="screen-title">{t('getx_graphql_app_bar_title')}</h2>
        </div>
        <button className="btn btn-outline" onClick={fetchGraphQLPhotos} disabled={loading}>
          <RefreshCw size={16} className={loading ? 'spin' : ''} />
        </button>
      </div>

      <div className="screen-card-panel" style={{ flexGrow: 1, display: 'flex', flexDirection: 'column' }}>
        {loading ? (
          <div style={{ margin: 'auto' }} className="spinner" />
        ) : error ? (
          <div style={{ margin: 'auto', textAlign: 'center' }}>
            <AlertCircle size={48} color="var(--accent-error)" style={{ marginBottom: '1rem' }} />
            <p style={{ marginBottom: '1.5rem', color: 'var(--text-secondary)' }}>{error}</p>
            <button className="btn btn-primary" onClick={fetchGraphQLPhotos}>{t('retry')}</button>
          </div>
        ) : (
          <>
            <div className="photo-stats-bar">
              <span style={{ fontWeight: 600, color: 'var(--accent-secondary)' }}>
                {t('graphql_photos_count', { count: photos.length })}
              </span>
              <span style={{ fontStyle: 'italic', color: 'var(--text-muted)' }}>{t('powered_by_getx_graphql')}</span>
            </div>

            <div className="photo-grid">
              {photos.map(photo => (
                <div key={photo.id} className="photo-card" onClick={() => setSelectedPhoto(photo)}>
                  <span className="photo-card-id">#{photo.id}</span>
                  <div className="photo-card-img-wrapper">
                    <img src={photo.thumbnailUrl} alt={photo.title} className="photo-card-img" loading="lazy" />
                  </div>
                  <div className="photo-card-content">
                    <h4 className="photo-card-title">{photo.title}</h4>
                    <div className="photo-card-album">
                      <Layers size={11} />
                      <span>Album {photo.albumId}</span>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </>
        )}
      </div>

      {selectedPhoto && (
        <PhotoModal photo={selectedPhoto} onClose={() => setSelectedPhoto(null)} t={t} />
      )}
    </div>
  );
}

/* =============================================================================
   6. ISOLATES SCREEN (WEB WORKER PRIME CALCULATION)
   ============================================================================= */
function IsolatesScreen({ t }) {
  const [isLoading, setIsLoading] = useState(false);
  const [executionTime, setExecutionTime] = useState('-');
  const [result, setResult] = useState('-');
  const [runMethod, setRunMethod] = useState('-');

  // Heavy CPU-bound computation: Counting primes up to [max]
  const countPrimes = (max) => {
    let count = 0;
    for (let i = 2; i <= max; i++) {
      let isPrime = true;
      for (let j = 2; j * j <= i; j++) {
        if (i % j === 0) {
          isPrime = false;
          break;
        }
      }
      if (isPrime) count++;
    }
    return count;
  };

  // Runs computation directly on the main thread (blocks UI/spinner)
  const runOnMainThread = () => {
    setIsLoading(true);
    setRunMethod(t('isolates_run_method_main'));
    setExecutionTime(t('isolates_calculating'));
    setResult(t('isolates_dash'));

    // 100ms delay to let React update the loading state before blocking
    setTimeout(() => {
      const startTime = performance.now();
      const count = countPrimes(8000000); // 8 million
      const endTime = performance.now();
      const duration = Math.round(endTime - startTime);

      setIsLoading(false);
      setExecutionTime(`${duration} ms`);
      setResult(t('isolates_primes_found', { count }));
    }, 100);
  };

  // Runs computation in a background Web Worker (UI spinner keeps running smoothly)
  const runOnIsolate = () => {
    setIsLoading(true);
    setRunMethod(t('isolates_run_method_isolate'));
    setExecutionTime(t('isolates_calculating'));
    setResult(t('isolates_dash'));

    const startTime = performance.now();

    // Spawn web worker
    const worker = new Worker(new URL('./workers/primeWorker.js', import.meta.url));

    worker.postMessage(8000000); // Compute primes up to 8 million

    worker.onmessage = (e) => {
      const count = e.data;
      const endTime = performance.now();
      const duration = Math.round(endTime - startTime);

      setIsLoading(false);
      setExecutionTime(`${duration} ms`);
      setResult(t('isolates_primes_found', { count }));
      worker.terminate();
    };

    worker.onerror = (err) => {
      setIsLoading(false);
      setExecutionTime('Error');
      setResult(err.message);
      worker.terminate();
    };
  };

  return (
    <div className="screen-container">
      <div className="screen-header">
        <div className="screen-title-area">
          <span className="badge-pill badge-performance">Performance</span>
          <h2 className="screen-title">{t('isolates_app_bar_title')}</h2>
        </div>
      </div>

      <div className="screen-card-panel">
        <h3 style={{ fontSize: '1.25rem', marginBottom: '0.75rem' }}>{t('isolates_demo_title')}</h3>
        <p style={{ color: 'var(--text-secondary)', marginBottom: '1.25rem', fontSize: '0.95rem' }}>
          {t('isolates_description')}
        </p>
        <div className="isolates-warning-card">
          {t('isolates_main_thread_warning')}
        </div>
        <div className="isolates-info-card">
          {t('isolates_spawn_info')}
        </div>

        {/* Loading Spinner Area */}
        <div className="isolates-spinner-container">
          <div className="spinner" style={{ animationPlayState: isLoading ? 'running' : 'running' }} />
          <p style={{ marginTop: '0.75rem', fontStyle: 'italic', color: 'var(--text-muted)', fontSize: '0.9rem' }}>
            {isLoading ? t('isolates_computing') : t('isolates_idle')}
          </p>
        </div>

        {/* Buttons */}
        <div className="isolates-buttons">
          <button 
            className="btn btn-outline" 
            style={{ borderColor: 'rgba(239,68,68,0.3)', color: '#f87171', background: 'rgba(239,68,68,0.02)' }} 
            onClick={runOnMainThread} 
            disabled={isLoading}
          >
            {t('isolates_run_main_thread')}
          </button>
          <button 
            className="btn btn-outline" 
            style={{ borderColor: 'rgba(16,185,129,0.3)', color: '#34d399', background: 'rgba(16,185,129,0.02)' }} 
            onClick={runOnIsolate} 
            disabled={isLoading}
          >
            {t('isolates_run_isolate')}
          </button>
        </div>

        {/* Results */}
        <div className="results-panel">
          <div className="result-item">
            <span className="result-label">{t('isolates_method_label', { method: '' }).trim()}</span>
            <span className="result-value">{runMethod}</span>
          </div>
          <div className="result-item">
            <span className="result-label">{t('isolates_time_label', { time: '' }).trim()}</span>
            <span className="result-value">{executionTime}</span>
          </div>
          <div className="result-item">
            <span className="result-label">{t('isolates_result_label', { result: '' }).trim()}</span>
            <span className="result-value">{result}</span>
          </div>
        </div>
      </div>
    </div>
  );
}

/* =============================================================================
   7. WEBSOCKET ECHO CHAT SCREEN
   ============================================================================= */
function WebSocketScreen({ t }) {
  const [messages, setMessages] = useState([]);
  const [inputValue, setInputValue] = useState('');
  const [connectionState, setConnectionState] = useState('disconnected'); // disconnected, connecting, connected, error
  const [isTyping, setIsTyping] = useState(false);

  const socketRef = useRef(null);
  const chatMessagesEndRef = useRef(null);

  const connectWebSocket = () => {
    setConnectionState('connecting');
    
    if (socketRef.current) {
      socketRef.current.close();
    }

    try {
      const ws = new WebSocket('wss://ws.postman-echo.com/raw');
      socketRef.current = ws;

      ws.onopen = () => {
        setConnectionState('connected');
      };

      ws.onmessage = (event) => {
        // Postman echo returns exactly what we sent. Let's delay echo receipt to simulate server work/typing.
        setIsTyping(true);
        setTimeout(() => {
          setIsTyping(false);
          const echoMessage = {
            id: Date.now().toString(),
            text: event.data,
            sender: 'server',
            timestamp: new Date()
          };
          setMessages(prev => [...prev, echoMessage]);
        }, 1200);
      };

      ws.onerror = () => {
        setConnectionState('error');
      };

      ws.onclose = () => {
        setConnectionState(prev => (prev === 'connecting' || prev === 'error' ? 'error' : 'disconnected'));
      };
    } catch (e) {
      setConnectionState('error');
    }
  };

  useEffect(() => {
    connectWebSocket();
    return () => {
      if (socketRef.current) socketRef.current.close();
    };
  }, []);

  useEffect(() => {
    // Scroll messages area to bottom
    chatMessagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages, isTyping]);

  const handleSendMessage = (e) => {
    if (e) e.preventDefault();
    const text = inputValue.trim();
    if (!text) return;
    if (connectionState !== 'connected' || !socketRef.current) return;

    // Send via WebSocket
    socketRef.current.send(text);

    // Add message
    const userMessage = {
      id: Date.now().toString(),
      text: text,
      sender: 'me',
      timestamp: new Date(),
      status: 'delivered'
    };

    setMessages(prev => [...prev, userMessage]);
    setInputValue('');
  };

  const clearChat = () => {
    setMessages([]);
  };

  const getStatusLabel = () => {
    switch (connectionState) {
      case 'connected': return t('chat_status_connected');
      case 'connecting': return t('chat_status_connecting');
      case 'error': return t('chat_status_error');
      default: return t('chat_status_disconnected');
    }
  };

  const formatTime = (date) => {
    const hours = date.getHours().toString().padLeft(2, '0');
    const minutes = date.getMinutes().toString().padLeft(2, '0');
    return `${hours}:${minutes}`;
  };

  // Helper prototype padding
  if (!String.prototype.padLeft) {
    String.prototype.padLeft = function (length, character) {
      return this.padStart(length, character);
    };
  }

  return (
    <div className="screen-container">
      <div className="screen-header">
        <div className="screen-title-area">
          <span className="badge-pill badge-state">WebSocket</span>
          <h2 className="screen-title">{t('chat_title')}</h2>
        </div>
      </div>

      <div className="chat-container">
        {/* Connection status banner */}
        <div style={{ backgroundColor: 'var(--bg-tertiary)', padding: '0.75rem 1.25rem', borderBottom: '1px solid var(--border-glass)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
            <span className={`chat-status-dot chat-status-dot-${connectionState}`} />
            <span style={{ fontSize: '0.85rem', fontWeight: 600 }}>{getStatusLabel()}</span>
          </div>
          <button className="btn btn-outline btn-icon" onClick={clearChat} title={t('chat_clear_tooltip')}>
            <Trash2 size={16} />
          </button>
        </div>

        {connectionState === 'error' && (
          <div className="chat-banner chat-banner-error">
            <span>{t('chat_banner_error')}</span>
            <button className="btn btn-outline" style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem' }} onClick={connectWebSocket}>
              {t('retry')}
            </button>
          </div>
        )}

        {connectionState === 'disconnected' && (
          <div className="chat-banner chat-banner-disconnected">
            <span>{t('chat_banner_disconnected')}</span>
            <button className="btn btn-outline" style={{ padding: '0.25rem 0.5rem', fontSize: '0.75rem' }} onClick={connectWebSocket}>
              {t('retry')}
            </button>
          </div>
        )}

        {/* Message bubble viewport */}
        <div className="chat-messages">
          {messages.length === 0 ? (
            <div className="chat-empty">
              <MessageSquare size={48} className="chat-empty-icon" />
              <h3 style={{ fontSize: '1.25rem', marginBottom: '0.5rem', color: 'var(--text-primary)' }}>{t('chat_empty_title')}</h3>
              <p style={{ color: 'var(--text-secondary)', fontSize: '0.9rem', lineHeight: '1.5', whiteSpace: 'pre-line' }}>
                {t('chat_empty_subtitle')}
              </p>
            </div>
          ) : (
            <>
              <div className="chat-timestamp-header">{t('chat_today')}</div>
              {messages.map(msg => {
                const isMe = msg.sender === 'me';
                return (
                  <div key={msg.id} className={`chat-bubble-row ${isMe ? 'me' : 'server'}`}>
                    <div className="chat-bubble">
                      {!isMe && <span className="chat-sender-label">{t('chat_sender_server')}</span>}
                      <span>{msg.text}</span>
                      <div className="chat-bubble-footer">
                        <span>{formatTime(msg.timestamp)}</span>
                        {isMe && (
                          <span className="chat-status-icon">
                            <CheckCheck size={12} color="var(--accent-success)" />
                          </span>
                        )}
                      </div>
                    </div>
                  </div>
                );
              })}
            </>
          )}

          {/* Typing Indicator */}
          {isTyping && (
            <div className="chat-typing-row">
              <div className="chat-typing-bubble">
                <div className="typing-dots">
                  <span />
                  <span />
                  <span />
                </div>
              </div>
            </div>
          )}
          <div ref={chatMessagesEndRef} />
        </div>

        {/* Bottom Input */}
        <form className="chat-input-bar" onSubmit={handleSendMessage}>
          <input 
            type="text" 
            className="chat-input" 
            placeholder={t('chat_input_hint')} 
            value={inputValue}
            onChange={e => setInputValue(e.target.value)}
            disabled={connectionState !== 'connected'}
          />
          <button 
            type="submit" 
            className="btn btn-primary" 
            style={{ borderRadius: '50%', width: '40px', height: '40px', padding: '0', flexShrink: 0 }}
            disabled={connectionState !== 'connected' || !inputValue.trim()}
          >
            <Send size={16} />
          </button>
        </form>
      </div>
    </div>
  );
}

/* =============================================================================
   8. LIFTING STATE UP SCREEN (TECH SHOP CART)
   ============================================================================= */
const catalogProducts = [
  { id: 1, name: 'Wireless Headphones', price: 99.99, icon: 'headphones', color: '#3b82f6', description: 'Immersive sound with active noise cancellation and 40h battery life.' },
  { id: 2, name: 'Smart Watch Series X', price: 199.99, icon: 'watch', color: '#f97316', description: 'Track your health, workouts, and receive notifications on the go.' },
  { id: 3, name: 'Ergonomic Gaming Mouse', price: 49.99, icon: 'mouse', color: '#a855f7', description: 'Ultra-lightweight design with 16k DPI optical sensor for precision gaming.' },
  { id: 4, name: 'Mechanical Keyboard', price: 129.99, icon: 'keyboard', color: '#10b981', description: 'Tactile blue switches with customizable RGB lighting and premium build.' },
  { id: 5, name: 'Portable Bluetooth Speaker', price: 79.99, icon: 'speaker', color: '#ec4899', description: 'Waterproof IPX7 rating, deep bass, and 360-degree surrounding sound.' },
  { id: 6, name: 'Ultra Wide 4K Monitor', price: 349.99, icon: 'monitor', color: '#14b8a6', description: '34-inch curved display with HDR support, perfect for creators and gamers.' },
];

function LiftingStateScreen({ cartItems, setCartItems, showToast, t }) {
  const [subScreen, setSubScreen] = useState('catalog'); // catalog, cart
  const [orderTotal, setOrderTotal] = useState(0);
  const [showOrderPlacedModal, setShowOrderPlacedModal] = useState(false);

  const addToCart = (product) => {
    setCartItems(prev => [...prev, product]);
    showToast(t('item_added_to_cart', { name: product.name }));
  };

  const removeFromCart = (product) => {
    // Remove exactly one item matching the product id
    const idx = cartItems.findIndex(item => item.id === product.id);
    if (idx > -1) {
      const updated = [...cartItems];
      updated.splice(idx, 1);
      setCartItems(updated);
      showToast(t('item_removed_from_cart', { name: product.name }));
    }
  };

  // Group items by ID for listing counts
  const groupedCart = cartItems.reduce((acc, item) => {
    if (!acc[item.id]) {
      acc[item.id] = { ...item, count: 0 };
    }
    acc[item.id].count += 1;
    return acc;
  }, {});

  const subtotal = cartItems.reduce((sum, item) => sum + item.price, 0);
  const tax = subtotal * 0.10;
  const total = subtotal + tax;

  const handlePlaceOrder = () => {
    setOrderTotal(total.toFixed(2));
    setCartItems([]);
    setShowOrderPlacedModal(true);
  };

  return (
    <div className="screen-container">
      <div className="screen-header">
        <div className="screen-title-area">
          <span className="badge-pill badge-state">Lifting State Up</span>
          <h2 className="screen-title">{subScreen === 'catalog' ? t('tech_shop_title') : t('your_cart_title')}</h2>
        </div>
        
        {subScreen === 'catalog' ? (
          <button className="btn btn-primary" style={{ position: 'relative' }} onClick={() => setSubScreen('cart')}>
            <ShoppingCart size={16} />
            <span>{t('view_cart')}</span>
            {cartItems.length > 0 && <span className="cart-badge-count">{cartItems.length}</span>}
          </button>
        ) : (
          <button className="btn btn-outline" onClick={() => setSubScreen('catalog')}>
            {t('shop_products')}
          </button>
        )}
      </div>

      {subScreen === 'catalog' ? (
        <div style={{ animation: 'slide-up 0.3s ease-out' }}>
          <div className="cart-header-banner">
            {t('product_catalog_banner')}
          </div>
          <div className="catalog-grid">
            {catalogProducts.map(product => {
              const countInCart = cartItems.filter(item => item.id === product.id).length;
              return (
                <div key={product.id} className="product-card">
                  <div className="product-card-icon-box" style={{ backgroundColor: product.color }}>
                    {getIconComponent(product.icon)}
                  </div>
                  <h3 className="product-card-title">{product.name}</h3>
                  <p className="product-card-desc">{product.description}</p>
                  <div className="product-card-footer">
                    <span className="product-price">${product.price.toFixed(2)}</span>
                    <button className="btn btn-primary" style={{ padding: '0.5rem 1rem', fontSize: '0.85rem' }} onClick={() => addToCart(product)}>
                      {countInCart > 0 ? `${t('add_more')} (${countInCart})` : t('add_to_cart')}
                    </button>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      ) : (
        <div style={{ animation: 'slide-up 0.3s ease-out' }}>
          <div className="cart-header-banner cart-header-banner-orange">
            {t('cart_banner')}
          </div>

          {cartItems.length === 0 ? (
            <div className="screen-card-panel" style={{ textAlign: 'center', padding: '4rem 2rem' }}>
              <ShoppingCart size={48} color="var(--text-muted)" style={{ marginBottom: '1rem', opacity: 0.5 }} />
              <h3 style={{ marginBottom: '0.5rem' }}>{t('cart_empty_title')}</h3>
              <p style={{ color: 'var(--text-secondary)', marginBottom: '2rem' }}>{t('cart_empty_subtitle')}</p>
              <button className="btn btn-primary" onClick={() => setSubScreen('catalog')}>{t('shop_products')}</button>
            </div>
          ) : (
            <div style={{ display: 'grid', gridTemplateColumns: '1fr', gap: '2rem' }}>
              {/* Cart Items list */}
              <div className="cart-items-list">
                {Object.values(groupedCart).map(item => (
                  <div key={item.id} className="cart-item-row">
                    <div className="cart-item-info">
                      <div className="product-card-icon-box" style={{ backgroundColor: item.color, width: '2rem', height: '2rem', margin: 0 }}>
                        {getIconComponent(item.icon)}
                      </div>
                      <div className="cart-item-details">
                        <h4>{item.name}</h4>
                        <p>${item.price.toFixed(2)} x {item.count}</p>
                      </div>
                    </div>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                      <button className="btn btn-outline btn-icon" onClick={() => removeFromCart(item)} style={{ padding: '0.25rem' }}>
                        <Minus size={14} />
                      </button>
                      <span style={{ minWidth: '1.5rem', textAlign: 'center', fontWeight: 'bold' }}>{item.count}</span>
                      <button className="btn btn-outline btn-icon" onClick={() => addToCart(item)} style={{ padding: '0.25rem' }}>
                        <Plus size={14} />
                      </button>
                    </div>
                  </div>
                ))}
              </div>

              {/* Checkout details panel */}
              <div className="cart-checkout-card">
                <div className="checkout-row">
                  <span style={{ color: 'var(--text-secondary)' }}>{t('subtotal')}</span>
                  <span>${subtotal.toFixed(2)}</span>
                </div>
                <div className="checkout-row">
                  <span style={{ color: 'var(--text-secondary)' }}>{t('estimated_tax')}</span>
                  <span>${tax.toFixed(2)}</span>
                </div>
                <div className="checkout-row total">
                  <span>{t('order_total')}</span>
                  <span>${total.toFixed(2)}</span>
                </div>

                <div className="checkout-actions">
                  <button className="btn btn-outline" onClick={() => setSubScreen('catalog')}>
                    {t('shop_products')}
                  </button>
                  <button className="btn btn-primary" onClick={handlePlaceOrder}>
                    {t('proceed_to_checkout')}
                  </button>
                </div>
              </div>
            </div>
          )}
        </div>
      )}

      {/* Order Placed Success Modal */}
      {showOrderPlacedModal && (
        <div className="modal-backdrop" onClick={() => setShowOrderPlacedModal(false)}>
          <div className="modal-content" onClick={e => e.stopPropagation()} style={{ padding: '2rem', textAlign: 'center' }}>
            <div style={{ width: '4.5rem', height: '4.5rem', borderRadius: '50%', backgroundColor: 'rgba(16,185,129,0.15)', color: 'var(--accent-success)', display: 'flex', alignItems: 'center', justifySelf: 'center', justifyContent: 'center', marginBottom: '1.5rem' }}>
              <Check size={36} strokeWidth={3} />
            </div>
            <h3 style={{ fontSize: '1.75rem', marginBottom: '0.75rem' }}>{t('order_placed_title')}</h3>
            <p style={{ color: 'var(--text-secondary)', marginBottom: '2rem', lineHeight: '1.6' }}>
              {t('order_placed_message', { total: orderTotal })}
            </p>
            <button className="btn btn-primary" style={{ width: '100%' }} onClick={() => setShowOrderPlacedModal(false)}>
              {t('ok')}
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
